import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_enum.dart';
import 'package:secure_wave/core/providers/app_status_provider/models/app_status_model.dart';
import 'package:secure_wave/core/services/database_service/database_service.dart';
import 'package:secure_wave/core/services/device_info_service.dart';
import 'package:secure_wave/core/services/location_service.dart/i_location_service.dart';
import 'package:secure_wave/core/services/location_service.dart/location_service.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/database_service/i_database_service.dart';
import 'package:secure_wave/core/services/locator_service.dart';
import 'package:flutter/services.dart';

part 'app_status_handler.dart';

//TODO(Mujtaba) : Will uncomment this in case, it needed

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       switch (task) {
//         case 'statusCheck':
//           await AppStatusProvider.checkStatusInBackground();
//           break;
//       }
//       return true;
//     } catch (err) {
//       log('Background task error: $err');
//       return false;
//     }
//   });
// }

class AppStatusProvider extends ChangeNotifier {
  static const statusCheckFrequency = Duration(milliseconds: 1000);

  AppStatus _currentStatus = AppStatus.idle;
  AppStatus get currentStatus => _currentStatus;

  StreamSubscription? _statusSubscription;
  final IDatabaseService _databaseService;
  final INotificationService _notificationService;
  final IDeviceInfoService _deviceInfoService;
  final DeviceAdminManager _dam;
  final ILocationService _locationService;
  AppStatusProvider(
    this._databaseService,
    this._dam,
    this._notificationService,
    this._deviceInfoService,
    this._locationService,
  ) {
    initializeStatusListener();
    initializeAndStoreToken();
    //TODO(Mujtaba) : Will uncomment this in case, it needed
    // _initializeBackgroundTask();
  }

  AppStatusModel _appStatusModel = AppStatusModel();

  String get userName => (_appStatusModel.displayName?.isNotEmpty ?? false)
      ? _appStatusModel.displayName ?? 'New User'
      : 'New User';

  String? get duePaymentAmount => (_appStatusModel.paymentDueAmount?.isNotEmpty ?? false)
      ? _appStatusModel.paymentDueAmount ?? ''
      : null;

  String? get duePaymentDate => (_appStatusModel.paymentDueDate?.isNotEmpty ?? false)
      ? _appStatusModel.paymentDueDate ?? ''
      : null;

  static const platform = MethodChannel('secure_wave/app_control');

  void initializeStatusListener() async {
    _statusSubscription?.cancel();
    _statusSubscription = _databaseService
        .streamData('Devices/${await _deviceInfoService.getDeviceId()}')
        .listen(_handleStatusUpdate);
  }

  void _handleStatusUpdate(Map<String, dynamic> statusData) {
    final newStatus = AppStatus.fromString(statusData['app_status']);
    if (newStatus.isUserNotFound) {
      _initializeNewUser();
      notifyListeners();
      return;
    }

    _appStatusModel = AppStatusModel.fromJson(statusData);

    if (_currentStatus != newStatus) {
      _currentStatus = newStatus;
      AppStatusHandler.handleStatusChange(
        dam: _dam,
        status: newStatus,
        password: newStatus.isLockDevice ? statusData['app_password'] : null,
        onSyncLocation: () => sendLocationAndResetStatus(),
        // onLock: () => _showBlockedNotification(isLock: false),
      );
    }
    notifyListeners();
  }

  Future<void> _initializeNewUser() async {
    try {
      final deviceId = await _deviceInfoService.getDeviceId();
      final deviceModel = await _deviceInfoService.getDeviceModel();
      final initialData = {
        "CreatedBy": "Admin",
        "CreatedOn": DateTime.now().toIso8601String(),
        "DeviceId": deviceId,
        "DeviceName": deviceModel,
        "IMEI": "",
        "Manufacturer": deviceModel.split(' ').first,
        "Status": true,
        "app_password": "",
        "app_status": AppStatus.idle.name,
        "fcm_token": "",
        "display_name": "New User",
        "payment_due_amount": "",
        "payment_due_date": "",
      };

      await _databaseService.setData('Devices/$deviceId', initialData);
      await initializeAndStoreToken();
      await sendLocationAndResetStatus();
      initializeStatusListener();
    } catch (stack, e) {
      log('Failed to initialize new user: $e');
      log('Failed to initialize new user: $stack');
    }
  }

  //TODO(Mujtaba) : Will uncomment this in case, it needed

  // Future<void> _initializeBackgroundTask() async {
  //   await Workmanager().initialize(
  //     callbackDispatcher,
  //     isInDebugMode: false,
  //   );

  //   await Workmanager().registerPeriodicTask(
  //     'statusCheck',
  //     'statusCheck',
  //     frequency: statusCheckFrequency,
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //       requiresBatteryNotLow: true,
  //       requiresCharging: false,
  //       requiresDeviceIdle: false,
  //       requiresStorageNotLow: false,
  //     ),
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     backoffPolicy: BackoffPolicy.linear,
  //     backoffPolicyDelay: const Duration(minutes: 1),
  //   );
  // }

  static Future<void> checkStatusInBackground() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      final dam = DeviceAdminManager.instance;
      final deviceId = await DeviceInfoService().getDeviceId();
      final statusData = await DatabaseService().getData('Devices/${deviceId}');
      log('background status: $statusData');
      final newStatus = AppStatus.fromString(statusData['app_status']);

      if (newStatus.shouldBlockAccess) {
        // await _showBlockedNotification();
        dam.lockApp();
        dam.setKeepScreenAwake(true);

        try {
          await platform.invokeMethod('launchApp');
        } catch (e) {
          log('Failed to launch app: $e');
        }
        return;
      }

      AppStatusHandler.handleStatusChange(
        dam: dam,
        status: newStatus,
        password: statusData['app_password'],
        onLock: () => _showBlockedNotification(route: newStatus),
        onSyncLocation: () async {
          final locationService = LocationService();
          if (await locationService.requestLocationPermission()) {
            final locationData = await locationService.getCurrentLocationWithAddress();
            await DatabaseService().updateData(
              'Devices/$deviceId',
              {
                'last_location': locationData,
                'app_status': AppStatus.idle.name,
              },
            );
          }
        },
      );
    } catch (e) {
      log('Background status check error: $e');
    }
  }

  static Future<void> _showBlockedNotification({bool isLock = true, AppStatus? route}) async {
    final notificationService = NotificationService();
    await notificationService.showNotification(
      RemoteMessage(),
      title: 'Device Locked',
      body: 'Your device has been locked by the administrator.',
      payload: isLock ? jsonEncode({'route': route?.name}) : null,
    );
  }

  Future<void> initializeAndStoreToken() async {
    try {
      final fcmToken = await _notificationService.getToken();

      if (fcmToken != null) {
        // Check if user exists before updating FCM token
        final userData =
            await _databaseService.getData('Devices/${await _deviceInfoService.getDeviceId()}');
        log('userData: $userData');
        if (userData.isNotEmpty) {
          await _databaseService.updateData(
            'Devices/${await _deviceInfoService.getDeviceId()}',
            {'fcm_token': fcmToken},
          );
        }
      }
    } catch (e) {
      log('Failed to initialize FCM token: $e');
    }
  }

  Future<void> sendLocationAndResetStatus() async {
    try {
      final hasPermission = await _locationService.requestLocationPermission();
      if (!hasPermission) {
        return;
      }

      final locationData = await _locationService.getCurrentLocationWithAddress();
      final deviceId = await _deviceInfoService.getDeviceId();

      await _databaseService.updateData(
        'Devices/$deviceId',
        {
          'last_location': locationData,
          'app_status': AppStatus.idle.name,
        },
      );

      _currentStatus = AppStatus.idle;
      notifyListeners();
    } catch (e) {
      log('Failed to send location: $e');
    }
  }

  Future<void> updateStatus(AppStatus newStatus) async {
    try {
      final deviceId = await _deviceInfoService.getDeviceId();
      await _databaseService.updateData(
        'Devices/$deviceId',
        {'app_status': newStatus.name},
      );

      _currentStatus = newStatus;
      notifyListeners();
    } catch (e) {
      log('Failed to update status: $e');
    }
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}

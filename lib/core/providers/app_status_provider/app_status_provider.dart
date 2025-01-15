import 'dart:async';
import 'dart:developer';
import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_enum.dart';
import 'package:secure_wave/core/services/database_service/database_service.dart';
import 'package:secure_wave/core/services/device_info_service.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/database_service/i_database_service.dart';
import 'package:secure_wave/core/services/locator_service.dart';
import 'package:workmanager/workmanager.dart';

part 'app_status_handler.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case 'statusCheck':
          await AppStatusProvider.checkStatusInBackground();
          break;
      }
      return true;
    } catch (err) {
      log('Background task error: $err');
      return false;
    }
  });
}

class AppStatusProvider extends ChangeNotifier {
  static const statusCheckFrequency = Duration(seconds: 10);

  AppStatus _currentStatus = AppStatus.idle;
  AppStatus get currentStatus => _currentStatus;

  StreamSubscription? _statusSubscription;
  final IDatabaseService _databaseService;
  final INotificationService _notificationService;
  final IDeviceInfoService _deviceInfoService;
  final DeviceAdminManager _dam;
  AppStatusProvider(
    this._databaseService,
    this._dam,
    this._notificationService,
    this._deviceInfoService,
  ) {
    initializeStatusListener();
    _initializeBackgroundTask();
    initializeAndStoreToken();
  }

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

    if (_currentStatus != newStatus) {
      _currentStatus = newStatus;
      AppStatusHandler.handleStatusChange(
        dam: _dam,
        status: newStatus,
        password: newStatus.isLockDevice ? statusData['app_password'] : null,
      );
      notifyListeners();
    }
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
      };

      await _databaseService.setData('Devices/$deviceId', initialData);
      await initializeAndStoreToken();
      initializeStatusListener();
    } catch (stack, e) {
      log('Failed to initialize new user: $e');
      log('Failed to initialize new user: $stack');
    }
  }

  Future<void> _initializeBackgroundTask() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false, //kDebugMode,
    );

    await Workmanager().registerPeriodicTask(
      'statusCheck',
      'statusCheck',
      frequency: statusCheckFrequency,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static Future<void> checkStatusInBackground() async {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      final dam = DeviceAdminManager.instance;
      final deviceId = await DeviceInfoService().getDeviceId();
      final statusData = await DatabaseService().getData('Devices/${deviceId}');
      log('background status: $statusData');
      final newStatus = AppStatus.fromString(statusData['app_status']);

      // if (newStatus.shouldBlockAccess) {
      //   await _showBlockedNotification();
      //   dam.lockApp();
      //   dam.setKeepScreenAwake(true);
      //   return;
      // }

      AppStatusHandler.handleStatusChange(
        dam: dam,
        status: newStatus,
        password: statusData['app_password'],
      );
    } catch (e) {
      log('Background status check error: $e');
    }
  }

  // static Future<void> _showBlockedNotification() async {
  //   // Implement notification logic
  //   // You might want to use flutter_local_notifications
  // }

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

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}

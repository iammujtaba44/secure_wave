import 'dart:async';
import 'dart:developer';
import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:secure_wave/providers/app_status_provider/app_status_enum.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/services/database_service/i_database_service.dart';
import 'package:secure_wave/services/locator_service.dart';
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
  final DeviceAdminManager _dam;

  AppStatusProvider(this._databaseService, this._dam) {
    initializeStatusListener();
    _initializeBackgroundTask();
  }

  void initializeStatusListener() {
    _statusSubscription?.cancel();
    _statusSubscription =
        _databaseService.streamData('Devices/135468743521').listen(_handleStatusUpdate);
  }

  void _handleStatusUpdate(Map<String, dynamic> statusData) {
    final newStatus = AppStatus.fromString(statusData['app_status']);

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
      final dam = locator.get<DeviceAdminManager>();
      final statusData = await locator.get<IDatabaseService>().getData('Devices/135468743521');
      print('background status: $statusData');
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

  static Future<void> _showBlockedNotification() async {
    // Implement notification logic
    // You might want to use flutter_local_notifications
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }
}

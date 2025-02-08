import 'dart:convert';
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_enum.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/providers/database_provider.dart';
import 'package:secure_wave/core/services/database_service/database_service.dart';
import 'package:secure_wave/core/services/device_info_service.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/locator_service.dart';

part 'secure_wave_app.dart';

const platform = MethodChannel('secure_wave/app_control');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const LocatorService().setup();

  FlutterForegroundTask.initCommunicationPort();
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_task_channel',
      channelName: 'Foreground Task Channel',
      channelDescription: 'Channel for Foreground Task',
    ),
    iosNotificationOptions: IOSNotificationOptions(),
    foregroundTaskOptions: ForegroundTaskOptions(
      autoRunOnBoot: true,
      autoRunOnMyPackageReplaced: true,
      allowWakeLock: true,
      eventAction: ForegroundTaskEventAction.repeat(5000),
    ),
  );
  await backgroundTask();
  await setResetRestriction();

  initKioskMode();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: locator.get<ScreenAwakeProvider>()),
      ChangeNotifierProvider(create: (_) => LockProvider(dam: locator.get())),
      ChangeNotifierProvider(create: (_) => DatabaseProvider(dbService: locator.get())),
      ChangeNotifierProvider.value(value: locator.get<EmergencyProvider>()),
      ChangeNotifierProvider.value(value: locator.get<AppStatusProvider>()),
    ],
    child: const SecureWaveApp(),
  ));
}

Future<void> backgroundTask() async {
  FlutterForegroundTask.startService(
    notificationTitle: 'Admin App Running',
    notificationText: 'Listening to Firebase Realtime Database',
    callback: startListeningToFirebase,
  );
}

Future<void> startListeningToFirebase() async {
  print('startListeningToFirebase');
  WidgetsFlutterBinding.ensureInitialized();

  platform.setMethodCallHandler((call) async {
    switch (call.method) {
      case 'launchApp':
        return true;
      default:
        throw PlatformException(
          code: 'NotImplemented',
          message: 'Method ${call.method} not implemented',
        );
    }
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final DatabaseService databaseService = DatabaseService();
  final DeviceInfoService deviceInfoService = DeviceInfoService();
  databaseService
      .streamData('Devices/${await deviceInfoService.userId()}')
      .listen(_handleStatusUpdateOnBackground);
}

_handleStatusUpdateOnBackground(Map<String, dynamic> statusData) async {
  final newStatus = AppStatus.fromString(statusData['app_status']);
  if (newStatus.isUserNotFound || newStatus.isIdle) {
    return;
  }
  if (newStatus.isLockDeviceFunctionality) {
    final dam = DeviceAdminManager.instance;

    try {
      // First try using FlutterForegroundTask
      FlutterForegroundTask.launchApp();

      // Then try direct activity launch
      const intent = AndroidIntent(
        action: 'com.ib.secure.LAUNCH_APP',
        package: 'com.ib.secure',
        componentName: 'com.ib.secure.MainActivity',
        flags: <int>[
          Flag.FLAG_ACTIVITY_NEW_TASK,
          Flag.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED,
          Flag.FLAG_ACTIVITY_SINGLE_TOP,
          Flag.FLAG_ACTIVITY_CLEAR_TOP,
        ],
      );
      await intent.launch();

      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      log('Failed to launch app: $e');
      try {
        // Try alternative launch method
        const fallbackIntent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          package: 'com.ib.secure',
          flags: <int>[
            Flag.FLAG_ACTIVITY_NEW_TASK,
            Flag.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED,
          ],
        );
        await fallbackIntent.launch();
      } catch (e) {
        log('All launch attempts failed: $e');
        _showBlockedNotification(isLock: true, route: newStatus);
      }
    }

    AppStatusHandler.handleStatusChange(
      dam: dam,
      status: newStatus,
      password: newStatus.isLockDevice ? statusData['app_password'] : null,
      shouldKeepScreenAwake: false,
    );
  }
}

Future<void> _showBlockedNotification({bool isLock = true, AppStatus? route}) async {
  if (route == AppStatus.idle) {
    return;
  }
  final notificationService = NotificationService();
  await notificationService.showNotification(
    RemoteMessage(),
    title: 'Happy Admin',
    body: 'Your device is controlled by the administrator.',
    payload: isLock ? jsonEncode({'route': route?.name}) : null,
  );
}

class AppControl {
  static const MethodChannel _channel = MethodChannel('secure_wave/app_control');

  static Future<void> launchApp() async {
    await _channel.invokeMethod('launchApp');
  }
}

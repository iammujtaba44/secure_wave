import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

part 'secure_wave_app.dart';

const platform = MethodChannel('secure_wave/app_control');

void showAppToast(String message, {bool isError = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? Colors.red : Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize global error handling
    _setupErrorHandling();

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
  } catch (e, stack) {
    showAppToast("Crash in main(): $e", isError: true);
    log("Main initialization error", error: e, stackTrace: stack);
  }
}

void _setupErrorHandling() {
  // Handle Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    showAppToast("Flutter Error: ${details.exception}", isError: true);
    log("Flutter Error: ${details.exception}", stackTrace: details.stack);
  };

  // Handle platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    showAppToast("Platform Error: $error", isError: true);
    log("Platform Error: $error", stackTrace: stack);
    return true;
  };

  // Handle async errors
  runZonedGuarded(() async {
    // Your initialization code here
  }, (error, stackTrace) {
    showAppToast("Async Error: $error", isError: true);
    log("Async Error: $error", stackTrace: stackTrace);
  });
}

Future<void> backgroundTask() async {
  try {
    FlutterForegroundTask.startService(
      notificationTitle: '',
      notificationText: '',
      callback: startListeningToFirebase,
    );
  } catch (e, stack) {
    log("Background task error", error: e, stackTrace: stack);
  }
}

Future<void> startListeningToFirebase() async {
  try {
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
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }

    final DatabaseService databaseService = DatabaseService();
    final DeviceInfoService deviceInfoService = DeviceInfoService();

    databaseService
        .streamData('Devices/${await deviceInfoService.userId()}')
        .listen(_handleStatusUpdateOnBackground);
  } catch (e, stack) {
    log("Firebase listener error", error: e, stackTrace: stack);
  }
}

_handleStatusUpdateOnBackground(Map<String, dynamic> statusData) async {
  final DeviceInfoService deviceInfoService = DeviceInfoService();

  try {
    final status =
        statusData['app_status'] ?? statusData['${await deviceInfoService.userId()}']['app_status'];
    final newStatus = AppStatus.fromString(status);
    debugPrint('newStatus-BG: $newStatus');

    if (newStatus.isUserNotFound || newStatus.isIdle) {
      return;
    }

    if (newStatus.isLockDeviceFunctionality) {
      final dam = DeviceAdminManager.instance;

      try {
        FlutterForegroundTask.launchApp();

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
      } catch (e) {
        log('Failed to launch app: $e');
        try {
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
  } catch (e, stack) {
    log("Status update error", error: e, stackTrace: stack);
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

// Future<void> handleProvisioningComplete() async {
//   try {
//     showAppToast("Starting device provisioning...");

//     final dam = locator.get<DeviceAdminManager>();
//     showAppToast("Setting as profile owner...");
//     await dam.setAsProfileOwner();

//     // Add delay to ensure profile owner is set
//     await Future.delayed(const Duration(seconds: 1));

//     showAppToast("Initializing Firebase...");
//     await initializeFirebase();

//     showAppToast("Initializing background tasks...");
//     await initializeBackgroundTasks();

//     showAppToast("Device provisioning completed successfully");
//   } catch (e, stack) {
//     showAppToast("Provisioning error: $e", isError: true);
//     log("Provisioning error", error: e, stackTrace: stack);
//   }
// }

// void onQRCodeScanned(String result) async {
//   try {
//     // Handle QR code result
//     // ...

//     // Handle provisioning completion
//     await handleProvisioningComplete();
//   } catch (e, stack) {
//     log("QR code handling error", error: e, stackTrace: stack);
//     showAppToast("QR code error: $e", isError: true);
//   }
// }

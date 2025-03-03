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
import 'package:secure_wave/core/services/database_service/i_database_service.dart';

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
    showAppToast("App starting...");

    // Initialize global error handling
    _setupErrorHandling();

    showAppToast("Initializing locator service...");
    await const LocatorService().setup();
    showAppToast("Locator service initialized");

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: locator.get<ScreenAwakeProvider>()),
        ChangeNotifierProvider(create: (_) => LockProvider(dam: locator.get())),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(dbService: locator.get())),
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

Future<void> initializeFirebase() async {
  try {
    showAppToast("Initializing Firebase...");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    showAppToast("Firebase initialized successfully");
  } catch (e, stack) {
    showAppToast("Firebase initialization failed: $e", isError: true);
    log("Firebase init error", error: e, stackTrace: stack);
  }
}

Future<void> backgroundTask() async {
  try {
    showAppToast("Starting background service...");
    FlutterForegroundTask.startService(
      notificationTitle: '',
      notificationText: '',
      callback: startListeningToFirebase,
    );
    showAppToast("Background service started");
  } catch (e, stack) {
    showAppToast("Background task error: $e", isError: true);
    log("Background task error", error: e, stackTrace: stack);
  }
}

Future<void> startListeningToFirebase() async {
  try {
    showAppToast("Starting Firebase listener...");
    debugPrint('startListeningToFirebase');
    WidgetsFlutterBinding.ensureInitialized();

    platform.setMethodCallHandler((call) async {
      showAppToast("Method call: ${call.method}");
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

    final DatabaseService databaseService = DatabaseService();
    final DeviceInfoService deviceInfoService = DeviceInfoService();

    showAppToast("Setting up database listener...");
    databaseService
        .streamData('Devices/${await deviceInfoService.userId()}')
        .listen(_handleStatusUpdateOnBackground);

    showAppToast("Firebase listener started successfully");
  } catch (e, stack) {
    showAppToast("Firebase listener error: $e", isError: true);
    log("Firebase listener error", error: e, stackTrace: stack);
  }
}

_handleStatusUpdateOnBackground(Map<String, dynamic> statusData) async {
  try {
    showAppToast("Handling status update...");
    final newStatus = AppStatus.fromString(statusData['app_status']);

    if (newStatus.isUserNotFound || newStatus.isIdle) {
      showAppToast("Status: ${newStatus.toString()}");
      return;
    }

    if (newStatus.isLockDeviceFunctionality) {
      showAppToast("Locking device functionality...");
      final dam = DeviceAdminManager.instance;

      try {
        showAppToast("Launching app...");
        FlutterForegroundTask.launchApp();

        showAppToast("Setting up intent...");
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
        showAppToast("Intent launched successfully");
      } catch (e) {
        showAppToast("Launch error: $e", isError: true);
        log('Failed to launch app: $e');
        try {
          showAppToast("Trying fallback launch...");
          const fallbackIntent = AndroidIntent(
            action: 'android.intent.action.MAIN',
            package: 'com.ib.secure',
            flags: <int>[
              Flag.FLAG_ACTIVITY_NEW_TASK,
              Flag.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED,
            ],
          );
          await fallbackIntent.launch();
          showAppToast("Fallback launch successful");
        } catch (e) {
          showAppToast("All launch attempts failed: $e", isError: true);
          log('All launch attempts failed: $e');
          _showBlockedNotification(isLock: true, route: newStatus);
        }
      }

      showAppToast("Handling status change...");
      AppStatusHandler.handleStatusChange(
        dam: dam,
        status: newStatus,
        password: newStatus.isLockDevice ? statusData['app_password'] : null,
        shouldKeepScreenAwake: false,
      );
    }
  } catch (e, stack) {
    showAppToast("Status update error: $e", isError: true);
    log("Status update error", error: e, stackTrace: stack);
  }
}

Future<void> _showBlockedNotification(
    {bool isLock = true, AppStatus? route}) async {
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
  static const MethodChannel _channel =
      MethodChannel('secure_wave/app_control');

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

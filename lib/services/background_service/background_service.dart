import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/services/database_service/i_database_service.dart';
import 'package:secure_wave/services/locator_service.dart';

class BackgroundService {
  Future<void> initializeBackgroundService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'Database Listening Service',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  void onStart(ServiceInstance service) async {
    // Initialize Firebase in background service
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Initialize database service
    final databaseService = locator.get<IDatabaseService>();

    // Set up listeners for different data types
    await databaseService.listenWithBackground(
      'devices',
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          // Update notification with latest device count
          // service.setAsForegroundService(
          //   title: 'Database Listening Service',
          //   content: 'Monitoring ${event.snapshot.children.length} devices',
          // );

          // You can send data to your main app if needed
          service.invoke('devices_updated', {
            'count': event.snapshot.children.length,
            'timestamp': DateTime.now().toIso8601String(),
          });
        }
      },
    );

    // Example: Listen to specific user data
    await databaseService.listenToUserDataWithBackground(
      'someUserId',
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          // Handle user data updates
          service.invoke('user_data_updated', {
            'data': event.snapshot.value,
            'timestamp': DateTime.now().toIso8601String(),
          });
        }
      },
    );

    // Keep the service alive by periodically updating the notification
    // Timer.periodic(const Duration(minutes: 15), (_) {
    //   service.setNotificationInfo(
    //     title: 'Database Listening Service',
    //     content: 'Active - Last check: ${DateTime.now().toString()}',
    //   );
    // });
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  void listenToBackgroundService() {
    FlutterBackgroundService().on('devices_updated').listen((event) {
      if (event != null) {
        print('Devices updated: ${event['count']} devices');
        // Handle the update
      }
    });

    FlutterBackgroundService().on('user_data_updated').listen((event) {
      if (event != null) {
        print('User data updated: ${event['data']}');
        // Handle the update
      }
    });
  }
}

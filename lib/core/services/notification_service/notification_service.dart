import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:secure_wave/core/services/notification_service/model/notification_result.dart';

part 'i_notification_service.dart';

typedef NotificationRedirection = void Function(NotificationResult route);

class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize(NotificationRedirection onNotificationReceived) async {
    // Request permission
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        try {
          final payload = jsonDecode(details.payload ?? '{}') as Map<String, dynamic>;
          final body = jsonDecode(payload['body'] as String) as Map<String, dynamic>;

          onNotificationReceived(NotificationResult(
            title: payload['title'] ?? '',
            message: body['message'] ?? '',
            media: body['media'] ?? null,
            mediaType: MediaType.fromJson(body['media_type'] ?? 'text'),
          ));
        } catch (stack, e) {
          log('onDidReceiveNotificationResponse Error: $stack');
          log('onDidReceiveNotificationResponse Error: $e');
        }
      },
    );

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Received message onMessage: ${message.toMap()}');
      log('Received message onMessage: ${message.notification?.title}');
      log('Received message onMessage: ${message.notification?.body}');
      _showNotification(message);
    });

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Received message onMessageOpenedApp: ${message.data}');
      log('Received message onMessageOpenedApp: ${message.notification?.title}');
      log('Received message onMessageOpenedApp: ${message.notification?.body}');
      onNotificationReceived(NotificationResult(
        title: message.notification?.title ?? '',
        message: message.notification?.body ?? '',
        notificationId: message.messageId ?? null,
        media: message.data['media'] ?? null,
        mediaType: MediaType.fromJson(message.data['mediaType'] ?? 'text'),
        data: message.data,
      ));
      // Handle notification tap when app is in background
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final body = jsonDecode(message.notification?.body as String) as Map<String, dynamic>;

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      body['message'] ?? '',
      platformChannelSpecifics,
      payload: jsonEncode({
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
      }),
    );
  }

  @override
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages here
  print("Handling a background message: ${message.messageId}");
  log("Handling a background message: ${message.messageId}");
  log("Handling a background message: ${message.notification?.title}");
  log("Handling a background message: ${message.notification?.body}");
}

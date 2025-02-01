import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_enum.dart';
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
          log('onDidReceiveNotificationResponse: ${details.payload}');
          final payload = jsonDecode(details.payload ?? '{}') as Map<String, dynamic>;
          if (payload['route'] != null) {
            onNotificationReceived(NotificationResult(
              title: payload['title'] ?? '',
              message: payload['body'] ?? '',
              route: payload['route'] != null ? AppStatus.fromString(payload['route']) : null,
            ));
            return;
          }

          final body = jsonDecode(details.payload ?? '{}') as Map<String, dynamic>;

          onNotificationReceived(NotificationResult(
            title: body['title'] ?? '',
            message: body['message'] ?? '',
            media: body['media'] ?? null,
            mediaType: MediaType.fromJson(body['media_type'] ?? 'text'),
            route: body['route'] != null ? AppStatus.fromString(body['route']) : null,
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
      showNotification(message);
    });

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final payload = message.data;
      if (payload['route'] != null) {
        onNotificationReceived(NotificationResult(
          title: payload['title'] ?? '',
          message: payload['body'] ?? '',
          route: payload['route'] != null ? AppStatus.fromString(payload['route']) : null,
        ));

        return;
      }
      onNotificationReceived(NotificationResult(
        title: payload['title'] ?? '',
        message: payload['message'] ?? '',
        media: payload['media'] ?? null,
        mediaType: MediaType.fromJson(payload['media_type'] ?? 'text'),
        route: payload['route'] != null ? AppStatus.fromString(payload['route']) : null,
      ));
    });
  }

  @override
  Future<void> showNotification(
    RemoteMessage message, {
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    if (title != null || body != null) {
      await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: payload ?? '',
      );
      return;
    }

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
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
  log("Handling a background message: ${message.data}");
}

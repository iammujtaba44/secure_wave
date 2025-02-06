part of 'notification_service.dart';

abstract class INotificationService {
  Future<void> initialize(NotificationRedirection onNotificationReceived);
  Future<String?> getToken();
  Future<void> showNotification(RemoteMessage message,
      {String? title, String? body, String? payload});
}

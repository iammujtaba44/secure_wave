part of 'notification_service.dart';

abstract class INotificationService {
  Future<void> initialize(NotificationRedirection onNotificationReceived);
  Future<String?> getToken();
}

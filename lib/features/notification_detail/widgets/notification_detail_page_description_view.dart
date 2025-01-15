import 'package:flutter/material.dart';
import 'package:secure_wave/core/services/notification_service/model/notification_result.dart';
import 'package:secure_wave/features/notification_detail/widgets/notification_view_widget.dart';

class NotificationDetailPageDescriptionView extends StatelessWidget {
  const NotificationDetailPageDescriptionView({required this.notification});

  final NotificationResult notification;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        NotificationDetailItemWidget(
          keyText: 'Title',
          valueText: notification.title,
        ),
        if (notification.message.isNotEmpty) ...[
          NotificationDetailItemWidget(
            keyText: 'Message',
            valueText: notification.message,
          ),
        ],
      ],
    );
  }
}

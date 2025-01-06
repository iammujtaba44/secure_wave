import 'package:flutter/material.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNotificationItem(
          'Payment Reminder',
          'Your payment is overdue by 5 days',
          DateTime.now().subtract(const Duration(days: 5)),
          Colors.red,
        ),
        _buildNotificationItem(
          'Support Message',
          'Our team tried to reach you via phone',
          DateTime.now().subtract(const Duration(days: 2)),
          Colors.orange,
        ),
        _buildNotificationItem(
          'System Update',
          'Device security update available',
          DateTime.now().subtract(const Duration(days: 1)),
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildNotificationItem(
    String title,
    String message,
    DateTime date,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

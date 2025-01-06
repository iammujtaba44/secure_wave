import 'package:auto_route/auto_route.dart';
import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';
import 'package:secure_wave/features/emergency/widgets/emergency_card.dart';
import 'package:secure_wave/services/locator_service.dart';

class AlertTab extends StatelessWidget {
  const AlertTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const EmergencyCard(),
          const SizedBox(height: 16),
          _buildPaymentButton(context),
          const SizedBox(height: 16),
          _buildSupportButton(context),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return IBButton.regular(
      title: 'Make Payment Now',
      type: IBButtonType.primary,
      backgroundColor: Colors.green,
      onPressed: () async {
        // Implement payment logic
        await locator.get<DeviceAdminManager>().unlockApp();
        context.router.back();
      },
    );
  }

  Widget _buildSupportButton(BuildContext context) {
    return IBButton.regular(
      title: 'Contact Support',
      type: IBButtonType.primary,
      backgroundColor: Colors.blue,
      onPressed: () => _showSupportDialog(context),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Support Contact'),
          content: const Text('Call us at: +1 (555) 123-4567'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

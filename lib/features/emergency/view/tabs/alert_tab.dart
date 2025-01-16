import 'package:auto_route/auto_route.dart';
import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/features/emergency/widgets/emergency_card.dart';
import 'package:secure_wave/core/services/locator_service.dart';

class AlertTab extends StatelessWidget {
  const AlertTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppStatusProvider, EmergencyProvider>(
        builder: (context, appStatusProvider, emergencyProvider, child) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            EmergencyCard(
              title: emergencyProvider.support?.title ?? '',
              description: emergencyProvider.support?.description ?? '',
              amountDue: appStatusProvider.duePaymentAmount,
              dueDate: appStatusProvider.duePaymentDate,
            ),

            //TODO: Add payment button when required
            // _buildPaymentButton(context),

            _buildSupportButton(context, emergencyProvider.support?.contact ?? ''),
          ],
        ),
      );
    });
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

  Widget _buildSupportButton(BuildContext context, String? contact) {
    return IBButton.regular(
      title: 'Contact Support',
      type: IBButtonType.primary,
      backgroundColor: Colors.blue,
      onPressed: () => _showSupportDialog(context, contact),
    );
  }

  void _showSupportDialog(BuildContext context, String? contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Support Contact'),
          content: Text(contact ?? ''),
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

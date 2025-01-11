import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/features/actions/policy_actions.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:infinite_binary_ui_kit/infinite_binary_ui_kit.dart';

@RoutePage()
class DeviceAdminManagerPage extends StatelessWidget {
  const DeviceAdminManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IBColors.Snow1,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Device Admin Manager',
          style: context.theme.headlineSmall_F18xW700,
        ),
        centerTitle: true,
        backgroundColor: IBColors.Snow1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device Management',
                style: context.theme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your device security settings and policies',
                style: context.theme.bodyMedium?.copyWith(
                  color: IBColors.Grey3,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: policyActions.length,
                  itemBuilder: (context, index) {
                    final action = policyActions[index];
                    if (action.label == toggleScreenAwakeLabel) {
                      action.didPressed = () {
                        context.read<ScreenAwakeProvider>().updateScreenAwakeStatus();
                      };
                    }

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          action.task(context);
                          action.didPressed?.call();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 32,
                                color: IBColors.Teal1,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                action.label,
                                textAlign: TextAlign.center,
                                style: context.theme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

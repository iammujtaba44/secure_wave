import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/features/actions/policy_actions.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:secure_wave/core/theme/app_colors.dart';
import 'package:secure_wave/core/theme/app_theme.dart';

@RoutePage()
class DeviceAdminManagerPage extends StatelessWidget {
  const DeviceAdminManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Device Admin',
          style: context.theme.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Administration',
                  style: context.theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your device security settings and policies',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
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
                                  color: AppColors.teal,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  action.label,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.bodyMedium?.copyWith(
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
      ),
    );
  }
}

import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/locator_service.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _initNotificationService();
    _requestPhoneStatePermission();
  }

  @override
  Widget build(BuildContext context) {
    final appStatusProvider = context.watch<AppStatusProvider>();
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () async {
              //TODO: Add device admin manager Route
              // context.router.push(const DeviceAdminManagerRoute());
            },
            child: const Text('Secure Wave')),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(appStatusProvider),
            const SizedBox(height: 24),
            _buildStatsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(AppStatusProvider appStatusProvider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                appStatusProvider.userName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatCard('Files', '28', Colors.blue),
            const SizedBox(width: 16),
            _buildStatCard('Shared', '14', Colors.green),
            const SizedBox(width: 16),
            _buildStatCard('Saved', '32', Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initNotificationService() {
    locator.get<INotificationService>().initialize((result) {
      if (result.route != null) {
        AppStatusHandler.handleStatusChange(
          dam: DeviceAdminManager.instance,
          status: result.route!,
        );

        context.read<AppStatusProvider>().updateStatus(result.route!);
        return;
      }
      if (context.router.current.name != NotificationDetailRoute.name) {
        context.router.push(NotificationDetailRoute(notification: result));
      } else {
        context.router.replace(NotificationDetailRoute(notification: result));
      }
    });
  }

  Future<void> _requestPhoneStatePermission() async {
    if (await Permission.phone.request().isGranted) {
    } else {}
  }
}

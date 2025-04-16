import 'dart:async';
import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/main.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/locator_service.dart';
import 'package:secure_wave/core/theme/app_button.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  bool _isSetupComplete = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onInit() async {
    _initNotificationService();
  }

  @override
  Widget build(BuildContext context) {
    final appStatusProvider = context.watch<AppStatusProvider>();
    return Scaffold(
      // appBar: AppBar(
      //   title: GestureDetector(
      //       onTap: () async {
      //         //TODO: Add device admin manager Route
      //         // context.router.push(const DeviceAdminManagerRoute());
      //       },
      //       child: const Text('Secure Wave')),
      //   backgroundColor: Colors.blue,
      //   elevation: 0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Add welcome back view
          // _HomeWelcomeBackView(appStatusProvider: appStatusProvider),
          // const SizedBox(height: 200),
          Center(
            child: SetupSection(
              isLoading: _isLoading,
              isSetupComplete: _isSetupComplete,
              onSetup: _onSetup,
            ),
          ),
        ],
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

  void _onSetup() async {
    if (AppStatusHandler.checkPermissions() == true) {
      _isSetupComplete = true;
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await AppStatusHandler.setAdminRestrictions();
      await _onInit();
      context.read<AppStatusProvider>().initializeStatusListener();
      context.read<AppStatusProvider>().initializeAndStoreToken();
      setState(() {
        _isLoading = false;
        _isSetupComplete = true;
      });

      await backgroundTask();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class _HomeWelcomeBackView extends StatelessWidget {
  const _HomeWelcomeBackView({required this.appStatusProvider});

  final AppStatusProvider appStatusProvider;

  @override
  Widget build(BuildContext context) {
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
                'Welcome Back ',
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
}

class SetupSection extends StatelessWidget {
  const SetupSection(
      {super.key, required this.isLoading, required this.isSetupComplete, required this.onSetup});
  final bool isLoading;
  final bool isSetupComplete;
  final void Function() onSetup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'Setup Device',
          type: ButtonType.secondary,
          onPressed: () => onSetup.call(),
        ),
        const SizedBox(height: 20),
        if (isLoading)
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        if (isSetupComplete) ...[
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Device successfully set up!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}

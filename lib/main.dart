import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/providers/database_provider.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/locator_service.dart';

part 'secure_wave_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const LocatorService().setup();

  initKioskMode();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: locator.get<ScreenAwakeProvider>()),
      ChangeNotifierProvider(create: (_) => LockProvider(dam: locator.get())),
      ChangeNotifierProvider(create: (_) => DatabaseProvider(dbService: locator.get())),
      ChangeNotifierProvider.value(value: locator.get<EmergencyProvider>()),
      ChangeNotifierProvider(create: (_) => AppStatusProvider(locator.get(), locator.get())),
    ],
    child: const SecureWaveApp(),
  ));
}

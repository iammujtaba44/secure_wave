import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' show GlobalKey, NavigatorState, ScaffoldMessengerState;
import 'package:get_it/get_it.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/core/services/background_service/background_service.dart';
import 'package:secure_wave/core/services/database_service/database_service.dart';
import 'package:secure_wave/core/services/database_service/i_database_service.dart';

final locator = GetIt.instance;

sealed class ILocatorService {
  Future<void> setup();
}

class LocatorService implements ILocatorService {
  const LocatorService();
  @override
  Future<void> setup() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    _registerRouters();
    _setupServices();
    _setupProviders();

    locator.get<EmergencyProvider>()
      ..getSupportContact()
      ..getFAQ();

    //locator.get<BackgroundService>().initializeBackgroundService();
  }

  static void _setupServices() {
    locator.registerLazySingleton<DeviceAdminManager>(() => DeviceAdminManager.instance);
    locator.registerLazySingleton<IDatabaseService>(() => DatabaseService());
    locator.registerLazySingleton<BackgroundService>(() => BackgroundService());
  }

  static void _setupProviders() {
    locator.registerLazySingleton<ScreenAwakeProvider>(
      () => ScreenAwakeProvider(
        dam: locator.get(),
      ),
    );

    locator.registerLazySingleton<EmergencyProvider>(
      () => EmergencyProvider(
        databaseService: locator.get(),
      ),
    );
  }

  static void _registerRouters() {
    final appRouter = AppRouter(navigatorKey: NavigationService.navigatorKey);

    locator.registerLazySingleton<AppRouter>(() => appRouter);
  }
}

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}

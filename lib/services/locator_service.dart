import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart' show GlobalKey, NavigatorState, ScaffoldMessengerState;
import 'package:get_it/get_it.dart';
import 'package:secure_wave/providers/app_providers.dart';
import 'package:secure_wave/routes/app_routes.dart';

final locator = GetIt.instance;

abstract class LocatorService {
  static void setup() {
    locator.registerLazySingleton<DeviceAdminManager>(() => DeviceAdminManager.instance);

    _setupProviders();
    _registerRouters();
  }

  static void _setupProviders() {
    locator.registerLazySingleton<ScreenAwakeProvider>(
      () => ScreenAwakeProvider(
        dam: locator.get(),
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

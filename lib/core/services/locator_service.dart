import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' show GlobalKey, NavigatorState, ScaffoldMessengerState;
import 'package:get_it/get_it.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/core/services/device_info_service.dart';
import 'package:secure_wave/core/services/location_service.dart/i_location_service.dart';
import 'package:secure_wave/core/services/location_service.dart/location_service.dart';
import 'package:secure_wave/core/services/notification_service/notification_service.dart';
import 'package:secure_wave/features/companies/providers/company_provider.dart';
import 'package:secure_wave/features/companies/repositories/company_repository.dart';
import 'package:secure_wave/features/companies/usecases/get_companies_usecase.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/firebase_options.dart';
import 'package:secure_wave/core/providers/app_providers.dart';
import 'package:secure_wave/routes/app_routes.dart';
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
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
    _registerRouters();
    await _setupServices();
    _setupProviders();

    locator.get<EmergencyProvider>()
      ..getSupportContact()
      ..getFAQ();

    //locator.get<BackgroundService>().initializeBackgroundService();
  }

  Future<void> _setupServices() async {
    locator.registerLazySingleton<DeviceAdminManager>(() => DeviceAdminManager.instance);
    locator.registerLazySingleton<IDatabaseService>(() => DatabaseService());
    locator.registerLazySingleton<INotificationService>(() => NotificationService());
    locator.registerLazySingleton<IDeviceInfoService>(() => DeviceInfoService());
    locator.registerLazySingleton<ILocationService>(() => LocationService());

    // Register company-related services
    locator.registerLazySingleton<ICompanyRepository>(() => CompanyRepository());
    locator.registerLazySingleton<GetCompaniesUseCase>(
      () => GetCompaniesUseCase(locator.get<ICompanyRepository>()),
    );
  }

  static void _setupProviders() {
    locator.registerLazySingleton<AppStatusProvider>(
      () => AppStatusProvider(
        locator.get(),
        locator.get(),
        locator.get(),
        locator.get(),
        locator.get(),
      ),
    );
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

    // Register company provider
    locator.registerLazySingleton<CompanyProvider>(
      () => CompanyProvider(locator.get<GetCompaniesUseCase>()),
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

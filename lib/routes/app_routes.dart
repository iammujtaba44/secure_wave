library app_routes;

import 'package:auto_route/auto_route.dart';
import 'package:secure_wave/features/emergency/view/emergency_page.dart';
import 'package:secure_wave/routes/app_routes.gr.dart';

export 'package:secure_wave/routes/app_routes.gr.dart';
export 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  static PageRouteInfo get defaultInitialRoute {
    return const HomeRoute();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: EmergencyRoute.page),
        AutoRoute(page: DeviceAdminManagerRoute.page),
      ];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:secure_wave/features/device_admin_manager/views/device_admin_manager_page.dart'
    as _i1;
import 'package:secure_wave/features/emergency/view/emergency_page.dart' as _i2;
import 'package:secure_wave/features/home/views/home_page.dart' as _i3;

/// generated route for
/// [_i1.DeviceAdminManagerPage]
class DeviceAdminManagerRoute extends _i4.PageRouteInfo<void> {
  const DeviceAdminManagerRoute({List<_i4.PageRouteInfo>? children})
      : super(
          DeviceAdminManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeviceAdminManagerRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.DeviceAdminManagerPage();
    },
  );
}

/// generated route for
/// [_i2.EmergencyPage]
class EmergencyRoute extends _i4.PageRouteInfo<void> {
  const EmergencyRoute({List<_i4.PageRouteInfo>? children})
      : super(
          EmergencyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmergencyRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.EmergencyPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

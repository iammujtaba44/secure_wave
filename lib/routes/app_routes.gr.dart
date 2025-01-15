// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:secure_wave/core/services/notification_service/model/notification_result.dart'
    as _i7;
import 'package:secure_wave/features/device_admin_manager/views/device_admin_manager_page.dart'
    as _i1;
import 'package:secure_wave/features/emergency/view/emergency_page.dart' as _i2;
import 'package:secure_wave/features/home/views/home_page.dart' as _i3;
import 'package:secure_wave/features/notification_detail/views/notification_detail_page.dart'
    as _i4;

/// generated route for
/// [_i1.DeviceAdminManagerPage]
class DeviceAdminManagerRoute extends _i5.PageRouteInfo<void> {
  const DeviceAdminManagerRoute({List<_i5.PageRouteInfo>? children})
      : super(
          DeviceAdminManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeviceAdminManagerRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.DeviceAdminManagerPage();
    },
  );
}

/// generated route for
/// [_i2.EmergencyPage]
class EmergencyRoute extends _i5.PageRouteInfo<void> {
  const EmergencyRoute({List<_i5.PageRouteInfo>? children})
      : super(
          EmergencyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmergencyRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.EmergencyPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.NotificationDetailPage]
class NotificationDetailRoute
    extends _i5.PageRouteInfo<NotificationDetailRouteArgs> {
  NotificationDetailRoute({
    _i6.Key? key,
    required _i7.NotificationResult notification,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          NotificationDetailRoute.name,
          args: NotificationDetailRouteArgs(
            key: key,
            notification: notification,
          ),
          initialChildren: children,
        );

  static const String name = 'NotificationDetailRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationDetailRouteArgs>();
      return _i4.NotificationDetailPage(
        key: args.key,
        notification: args.notification,
      );
    },
  );
}

class NotificationDetailRouteArgs {
  const NotificationDetailRouteArgs({
    this.key,
    required this.notification,
  });

  final _i6.Key? key;

  final _i7.NotificationResult notification;

  @override
  String toString() {
    return 'NotificationDetailRouteArgs{key: $key, notification: $notification}';
  }
}

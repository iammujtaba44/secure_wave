part of 'app_status_provider.dart';

abstract class AppStatusHandler {
  static void handleStatusChange({
    required DeviceAdminManager dam,
    required AppStatus status,
    String? password,
  }) {
    _handleDeviceState(status, dam, password);
    _handleNavigation(status);
  }

  static void _handleDeviceState(AppStatus status, DeviceAdminManager dam, String? password) {
    switch (status) {
      case AppStatus.lock:
      case AppStatus.disabled:
      case AppStatus.maintenance:
      case AppStatus.wipe:
      case AppStatus.lockDevice:
        _applyLockState(dam, password);
      case AppStatus.unlock:
        dam.unlockApp();
      case AppStatus.idle:
      default:
        break;
    }
  }

  static void _handleNavigation(AppStatus status) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    switch (status) {
      case AppStatus.lock:
      case AppStatus.disabled:
      case AppStatus.maintenance:
      case AppStatus.wipe:
      case AppStatus.lockDevice:
        context.router.replaceAll([const EmergencyRoute()]);
      case AppStatus.unlock:
      case AppStatus.idle:
      default:
        context.router.replaceAll([const HomeRoute()]);
        break;
    }
  }

  static void _applyLockState(DeviceAdminManager dam, String? password) {
    if (password != null) {
      dam.lockDevice(password: password);
    } else {
      dam.lockApp();
    }
    dam.setKeepScreenAwake(true);
  }
}

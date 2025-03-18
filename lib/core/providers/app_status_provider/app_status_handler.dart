part of 'app_status_provider.dart';

abstract class AppStatusHandler {
  static void handleStatusChange({
    required DeviceAdminManager dam,
    required AppStatus status,
    String? password,
    Function? onSyncLocation,
    Function? onLock,
    bool shouldKeepScreenAwake = true,
  }) {
    _handleDeviceState(status, dam, password,
        onSyncLocation: onSyncLocation,
        onLock: onLock,
        shouldKeepScreenAwake: shouldKeepScreenAwake);
    _handleNavigation(status);
  }

  static void _handleDeviceState(
    AppStatus status,
    DeviceAdminManager dam,
    String? password, {
    Function? onSyncLocation,
    Function? onLock,
    bool shouldKeepScreenAwake = true,
  }) async {
    switch (status) {
      case AppStatus.syncLocation:
        onSyncLocation?.call();
        break;
      case AppStatus.lock:
      case AppStatus.disabled:
      case AppStatus.maintenance:
      case AppStatus.lockDevice:
        onLock?.call();
        _applyLockState(dam, password, shouldKeepScreenAwake: shouldKeepScreenAwake);
      case AppStatus.wipe:
        await dam.wipeData(flags: 1, reason: 'Device is being wiped');
      case AppStatus.removeAdmin:
        await dam.clearDeviceOwnerApp();
      case AppStatus.unlock:
        await dam.unlockApp();
      case AppStatus.idle:
      default:
        break;
    }
  }

  static void _handleNavigation(AppStatus status) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    switch (status) {
      case AppStatus.syncLocation:
      case AppStatus.removeAdmin:
      case AppStatus.wipe:
        break;
      case AppStatus.lock:
      case AppStatus.disabled:
      case AppStatus.maintenance:
      case AppStatus.lockDevice:
        context.router.replaceAll([const EmergencyRoute()]);
      case AppStatus.unlock:
      case AppStatus.idle:
      default:
        context.router.replaceAll([const HomeRoute()]);
        break;
    }
  }

  static void _applyLockState(DeviceAdminManager dam, String? password,
      {bool shouldKeepScreenAwake = true}) {
    if (password != null) {
      dam.lockDevice(password: password);
    } else {
      dam.lockApp();
    }

    if (shouldKeepScreenAwake) {
      dam.setKeepScreenAwake(true);
    }
  }

  static Future<void> setAdminRestrictions() async {
    final dam = DeviceAdminManager.instance;
    debugPrint('dam:: setAdminRestrictions:: isAdminActive: ${await dam.isAdminActive()}');
    if (await dam.isAdminActive()) {
      await Future.wait([
        dam.enableFactoryResetProtection(),
        dam.preventAppDataClearing(),
        dam.disableForceStop(),
        dam.disableAppControl(),
        dam.disableSafeBoot(),
        if (!kDebugMode) dam.disableAdbUninstall(),
      ]);
    }

    if (!await checkPermissions()) {
      await dam.applyPermission();
    }

    //TODO: Add FRP section

    // final googleAccountFRP = await dam.enableGoogleAccountFRP(['moiezdevtest@gmail.com']);
    // debugPrint('dam:: setAdminRestrictions:: googleAccountFRP: $googleAccountFRP');

    final automaticSystemUpdates = await dam.setAutomaticSystemUpdates();
    debugPrint('dam:: setAdminRestrictions:: automaticSystemUpdates: $automaticSystemUpdates');
  }

  static Future<bool> checkPermissions() async {
    final arePermissionsGranted = await Future.wait([
      Permission.phone.isGranted,
      Permission.notification.isGranted,
      Permission.location.isGranted,
    ]);

    return arePermissionsGranted.every((permission) => permission);
  }
}

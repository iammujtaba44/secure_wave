enum AppStatus {
  lockDevice,
  lock,
  unlock,
  disabled,
  maintenance,
  restricted,
  wipe,
  idle,
  userNotFound,
  syncLocation,
  removeAdmin;

  static AppStatus fromString(String status) {
    return AppStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => AppStatus.idle,
    );
  }

  String get message {
    switch (this) {
      case AppStatus.lock:
        return 'App is locked for security reasons';
      case AppStatus.lockDevice:
        return 'Device is locked for security reasons';
      case AppStatus.unlock:
        return 'App is unlocked and fully functional';
      case AppStatus.disabled:
        return 'App is temporarily disabled';
      case AppStatus.maintenance:
        return 'App is under maintenance';
      case AppStatus.restricted:
        return 'App access is restricted';
      case AppStatus.wipe:
        return 'Device is being wiped';
      case AppStatus.idle:
        return 'App is up and running';
      case AppStatus.userNotFound:
        return 'User not found';
      case AppStatus.syncLocation:
        return 'Syncing location';
      case AppStatus.removeAdmin:
        return 'Removing admin';
    }
  }

  bool get shouldBlockAccess {
    return this == AppStatus.lock || this == AppStatus.disabled || this == AppStatus.maintenance;
  }

  bool get isLockDevice => this == AppStatus.lockDevice;
  bool get isUserNotFound => this == AppStatus.userNotFound;
  bool get isSyncLocation => this == AppStatus.syncLocation;
}

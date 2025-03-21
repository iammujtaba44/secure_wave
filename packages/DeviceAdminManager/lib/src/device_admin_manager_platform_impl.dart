import 'package:flutter/services.dart';

import 'device_admin_manager.dart';
import 'device_admin_manager_platform.dart';

/// An implementation of [DeviceDeviceAdminManagerPlatform] that uses method channels.
class DeviceAdminManagerPlatformImpl extends DeviceAdminManagerPlatform {
  DeviceAdminManagerPlatformImpl();

  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel('device_admin_manager');

  @override
  void handleBootCompleted(handler) {
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'handleBootCompleted') {
        handler(DeviceAdminManager.instance);
      }
    });
  }

  @override
  Future<bool> addUserRestrictions(List<String> restrictions) async {
    return await _methodChannel.invokeMethod('addUserRestrictions', restrictions);
  }

  @override
  Future<bool> clearUserRestriction(List<String> restrictions) async {
    return await _methodChannel.invokeMethod('clearUserRestriction', restrictions);
  }

  @override
  Future<Map<String, String>?> getApplicationRestrictions(String packageName) {
    return _methodChannel.invokeMapMethod<String, String>(
        'getApplicationRestrictions', packageName);
  }

  @override
  Future<Map<String, dynamic>?> getDeviceInfo() {
    return _methodChannel.invokeMapMethod<String, dynamic>('getDeviceInfo');
  }

  @override
  Future<bool> installApplication(String? apkUrl) async {
    return await _methodChannel.invokeMethod('installApplication', apkUrl);
  }

  @override
  Future<bool> isAdminActive() async {
    return await _methodChannel.invokeMethod('isAdminActive');
  }

  @override
  Future<bool> isAppLocked() async {
    return await _methodChannel.invokeMethod('isAppLocked');
  }

  @override
  Future<bool> lockApp({bool home = true}) async {
    return await _methodChannel.invokeMethod('lockApp', {'home': home});
  }

  @override
  Future<bool> lockDevice({String? password}) async {
    return await _methodChannel.invokeMethod('lockDevice', {'password': password});
  }

  @override
  Future<bool> rebootDevice({String? reason}) async {
    return await _methodChannel.invokeMethod('rebootDevice', {'reason': reason});
  }

  @override
  Future<bool> wipeData({int flags = 0, String? reason}) async {
    return await _methodChannel.invokeMethod('wipeData', {
      'flags': flags,
      'reason': reason,
    });
  }

  @override
  Future<bool> requestAdminPrivilegesIfNeeded() async {
    return await _methodChannel.invokeMethod('requestAdminPrivilegesIfNeeded');
  }

  @override
  Future<void> setApplicationRestrictions(String packageName, Map<String, String> restrictions) {
    return _methodChannel.invokeMethod('setApplicationRestrictions', {
      'packageName': packageName,
      'restrictions': restrictions,
    });
  }

  @override
  Future<void> setKeepScreenAwake(bool enable) {
    return _methodChannel.invokeMethod('setKeepScreenAwake', {'enable': enable});
  }

  @override
  Future<bool> isScreenAwake() async {
    return await _methodChannel.invokeMethod('isScreenAwake');
  }

  @override
  Future<bool> unlockApp() async {
    return await _methodChannel.invokeMethod('unlockApp');
  }

  @override
  Future<void> clearDeviceOwnerApp({String? packageName}) {
    return _methodChannel.invokeMethod('clearDeviceOwnerApp', {'packageName': packageName});
  }

  @override
  Future<void> setCameraDisabled({required bool disabled}) {
    return _methodChannel.invokeMethod('setCameraDisabled', {'disabled': disabled});
  }

  @override
  Future<void> setKeyguardDisabled({required bool disabled}) {
    return _methodChannel.invokeMethod('setKeyguardDisabled', {'disabled': disabled});
  }

  @override
  Future<void> setScreenCaptureDisabled({required bool disabled}) {
    return _methodChannel.invokeMethod('setScreenCaptureDisabled', {'disabled': disabled});
  }

  @override
  Future<bool> startApp({String? packageName}) async {
    return await _methodChannel.invokeMethod('startApp', {'packageName': packageName});
  }

  @override
  Future<bool> setAsLauncher({bool enable = true}) async {
    return await _methodChannel.invokeMethod('setAsLauncher', {'enable': enable});
  }

  @override
  Future<void> clear() {
    return _methodChannel.invokeMethod('clear');
  }

  @override
  Future<String?> get(String contentKey, {String? defaultContent}) {
    return _methodChannel
        .invokeMethod('get', {'contentKey': contentKey, 'default': defaultContent});
  }

  @override
  Future<void> put(String contentKey, {String? content}) {
    return _methodChannel.invokeMethod('put', {'contentKey': contentKey, 'content': content});
  }

  @override
  Future<void> remove(String contentKey) {
    return _methodChannel.invokeMethod('remove', {'contentKey': contentKey});
  }

  @override
  Future<bool> enableFactoryResetProtection() async {
    return await _methodChannel.invokeMethod('enableFactoryResetProtection');
  }

  @override
  Future<bool> setPackagesSuspendedEnable() async {
    return await _methodChannel.invokeMethod('setPackagesSuspendedEnable');
  }

  @override
  Future<bool> setPackagesSuspendedDisable() async {
    return await _methodChannel.invokeMethod('setPackagesSuspendedDisable');
  }

  @override
  Future<bool> wipeExternalStorage() async {
    return await _methodChannel.invokeMethod('wipeExternalStorage');
  }

  @override
  Future<bool> wipeResetProtectionData() async {
    return await _methodChannel.invokeMethod('wipeResetProtectionData');
  }

  @override
  Future<bool> wipeNormalFactoryData() async {
    return await _methodChannel.invokeMethod('wipeNormalFactoryData');
  }

  @override
  Future<bool> removeUserRestriction() async {
    return await _methodChannel.invokeMethod('removeUserRestriction');
  }

  @override
  Future<bool> hardProtectDevice() async {
    return await _methodChannel.invokeMethod('hardProtectDevice');
  }

  @override
  Future<bool> setAllDeviceAdminPolicies() async {
    return await _methodChannel.invokeMethod('setAllDeviceAdminPolicies');
  }

  @override
  Future<bool> preventFactoryReset() async {
    return await _methodChannel.invokeMethod('preventFactoryReset');
  }

  @override
  Future<bool> preventAppUninstallation() async {
    return await _methodChannel.invokeMethod('preventAppUninstallation');
  }

  @override
  Future<bool> disableForceStop() async {
    return await _methodChannel.invokeMethod('disableForceStop');
  }

  @override
  Future<bool> disableAdbUninstall() async {
    return await _methodChannel.invokeMethod('disableAdbUninstall');
  }

  @override
  Future<bool> preventAppDataClearing() async {
    return await _methodChannel.invokeMethod('preventAppDataClearing');
  }

  @override
  Future<bool> preventAdbInteractions() async {
    return await _methodChannel.invokeMethod('preventAdbInteractions');
  }

  @override
  Future<bool> disableSafeBoot() async {
    return await _methodChannel.invokeMethod('disableSafeBoot');
  }

  //TODO(Mujtaba):  This is not working on Android 13 and above
  // @override
  // Future<bool> disableOemUnlock() async {
  //   return await _methodChannel.invokeMethod('disableOemUnlock');
  // }

  @override
  Future<bool> applyPermission() async {
    return await _methodChannel.invokeMethod('applyPermission');
  }

  @override
  Future<bool> disableAppControl() async {
    return await _methodChannel.invokeMethod('disableAppControl');
  }

  @override
  Future<bool> enableGoogleAccountFRP(List<String> googleAccounts) async {
    return await _methodChannel
        .invokeMethod('enableGoogleAccountFRP', {'googleAccounts': googleAccounts});
  }

  @override
  Future<bool> isFrpEnabled() async {
    return await _methodChannel.invokeMethod('isFrpEnabled');
  }

  @override
  Future<List<String>> getFrpAccounts() async {
    final result = await _methodChannel.invokeMethod('getFrpAccounts');
    // Convert the List<dynamic> or List<Object?> to List<String>
    if (result is List) {
      return result.map((item) => item.toString()).toList();
    }
    return [];
  }

  @override
  Future<dynamic> setAutomaticSystemUpdates() async {
    return await _methodChannel.invokeMethod('setAutomaticSystemUpdates');
  }
}

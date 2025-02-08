import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

abstract class IDeviceInfoService {
  Future<String> userId();
  Future<AndroidDeviceInfo?> deviceInfo();
}

class DeviceInfoService implements IDeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> userId() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      final deviceId = androidInfo.id.replaceAll(RegExp(r'[^\w\s]+'), '');

      final String deviceUserId = '${androidInfo.manufacturer}_${androidInfo.model}_${deviceId}';
      return deviceUserId;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      // Returns the identifierForVendor
      return iosInfo.identifierForVendor ?? 'unknown';
    }
    return 'unknown_platform';
  }

  @override
  Future<AndroidDeviceInfo?> deviceInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo;
    }
    return null;
  }
}

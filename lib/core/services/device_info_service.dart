import 'dart:io';
import 'package:device_admin_manager/device_manager.dart';
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
      final dam = DeviceAdminManager.instance;
      final deviceInfo = await dam.getDeviceInfo();
      final imei = deviceInfo?['imei'];
      final androidInfo = await _deviceInfo.androidInfo;
      final rgx = RegExp(r'[^\w\s]+');

      final String deviceUserId = imei ??
          '${androidInfo.manufacturer.toUpperCase()}_${androidInfo.model.replaceAll(rgx, '')}_${androidInfo.id.replaceAll(rgx, '')}';
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

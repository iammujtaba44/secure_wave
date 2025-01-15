import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

abstract class IDeviceInfoService {
  Future<String> getDeviceId();
  Future<String> getDeviceModel();
}

class DeviceInfoService implements IDeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      // Returns the identifierForVendor
      return iosInfo.identifierForVendor ?? 'unknown';
    }
    return 'unknown_platform';
  }

  @override
  Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      // Returns the identifierForVendor
      return iosInfo.identifierForVendor ?? 'unknown';
    }
    return 'unknown_platform';
  }
}

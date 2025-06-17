import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:kai_chat/core/base/model/register_mobile_device_request.dart';

class DeviceInfo {
  static Future<RegisterMobileDeviceRequest> getDeviceInfo() async {
    late final IosDeviceInfo iosInfo;
    late final AndroidDeviceInfo androidInfo;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String? manufacturer;
    String? model;
    String? osVersion;
    String? platform;
    String? uuid;
    String? serial;
    bool? virtual;

    if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      manufacturer = 'Apple';
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
      platform = "IOS";
      uuid = iosInfo.identifierForVendor;
      virtual = !iosInfo.isPhysicalDevice;
    } else if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      String? deviceId = await const AndroidId().getId();
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
      platform = "ANDROID";
      uuid = deviceId;
      virtual = !androidInfo.isPhysicalDevice;
      serial = androidInfo.serialNumber;
    }

    return RegisterMobileDeviceRequest(
      manufacturer: manufacturer,
      model: model,
      platform: platform,
      uuid: uuid,
      osVersion: osVersion,
      virtual: virtual,
      serial: serial,
    );
  }
}

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

import '../../domain/model/model.dart';

abstract class DeviceDetails {
  Future<DeviceInfo> getDeviceDetails();
}

class DeviceDetailsImplementer implements DeviceDetails {
  final DeviceInfoPlugin deviceInfoPlugin;
  final LocalPlatform localPlatform;

  DeviceDetailsImplementer(
      {required this.deviceInfoPlugin, required this.localPlatform});

  @override
  Future<DeviceInfo> getDeviceDetails() async {
    String name = "Unknown";
    String identifier = "Unknown";
    String version = "Unknown";

    try {
      bool isAndroid = localPlatform.isAndroid;
      bool isIOS = localPlatform.isIOS;
      if (isAndroid) {
        // return android device info
        var build = await deviceInfoPlugin.androidInfo;
        () {
          name = build.brand + " " + build.model;
          identifier = build.androidId;
          version = build.version.codename;
        };
      } else if (isIOS) {
        // return ios device info
        var build = await deviceInfoPlugin.iosInfo;
        () {
          name = build.name + " " + build.model;
          identifier = build.identifierForVendor;
          version = build.systemVersion;
        };
      }
    } on PlatformException {
      // return default data here
      return DeviceInfo(name, identifier, version);
    }
    return DeviceInfo(name, identifier, version);
  }
}

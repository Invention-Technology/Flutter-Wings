import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class WingsDeviceInfo {
  static WingsDeviceInfo? _instance;

  factory WingsDeviceInfo() {
    _instance ??= WingsDeviceInfo._();

    return _instance!;
  }

  late String app;
  late String buildNumber;
  late String version;

  bool haveDeviceData = false;

  WingsDeviceInfo._() {
    _init();
  }

  Future<void> _init() async {
    app = Platform.operatingSystem;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    buildNumber = packageInfo.buildNumber;
    version = packageInfo.version;

    haveDeviceData = true;
  }

  Map<String, dynamic> get deviceInfoRequestHeader {
    return {'app': '$app: $version+$buildNumber'};
  }
}

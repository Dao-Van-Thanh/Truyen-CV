import 'package:package_info_plus/package_info_plus.dart';

class Device {
  // static Future<String> getDeviceId() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       final androidId = await const AndroidId().getId() ?? '';
  //       return androidId;
  //     }
  //     if (Platform.isIOS) {
  //       final data = await deviceInfoPlugin.iosInfo;
  //       return data.identifierForVendor ?? '';
  //     }
  //     return '';
  //   } on PlatformException {
  //     debugPrint('Failed to get platform version');
  //     return '';
  //   } catch (e) {
  //     debugPrint('Error getting device ID: $e');
  //     return '';
  //   }
  // }

  // static Future<String> getDeviceName() async {
  //   try {
  //     final deviceNames = DeviceMarketingNames();
  //     return await deviceNames.getSingleName();
  //   } catch (e) {
  //     debugPrint('Error getting device name: $e');
  //     return '';
  //   }
  // }

  // static Future<Map<String, dynamic>> getDeviceInfo() async {
  //   final deviceInfo = DeviceInfoPlugin();
  //   Map<String, dynamic> deviceData = {};
  //   String platform = '';

  //   if (Platform.isAndroid) {
  //     final androidInfo = await deviceInfo.androidInfo;
  //     platform = 'android';
  //     deviceData = {
  //       'model': androidInfo.model,
  //       'manufacturer': androidInfo.manufacturer,
  //       'sdkInt': androidInfo.version.sdkInt,
  //       'release': androidInfo.version.release,
  //     };
  //   } else if (Platform.isIOS) {
  //     final iosInfo = await deviceInfo.iosInfo;
  //     platform = 'ios';
  //     deviceData = {
  //       'model': iosInfo.utsname.machine,
  //       'systemName': iosInfo.systemName,
  //       'systemVersion': iosInfo.systemVersion,
  //     };
  //   }

  //   final marketingName = await getDeviceName();
  //   final deviceId = await getDeviceId();

  //   return {
  //     'platform': platform,
  //     'deviceId': deviceId,
  //     'marketingName': marketingName,
  //     ...deviceData,
  //   };
  // }

  static Future<String> getVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;
      if (version.isEmpty && buildNumber.isEmpty) {
        return '1.0.0';
      }
      if (buildNumber.isEmpty) {
        return version;
      }
      return '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      print('Error getting app version: $e');
      throw Exception('Error getting app version: $e');
    }
  }

  const Device._();
}

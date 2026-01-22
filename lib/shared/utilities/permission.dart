import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  const PermissionUtil._();

  static Future<bool> checkAndRequestPermission() async {
    if (Platform.isIOS) return true;

    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 30) {
      var status = await Permission.storage.status;

      if (status.isGranted) {
        return true;
      } else {
        status = await Permission.storage.request();
        return status.isGranted;
      }
    } else {
      var status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      } else {
        status = await Permission.storage.request();
        return status.isGranted;
      }
    }
  }
}

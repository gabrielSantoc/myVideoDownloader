import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<void> checkAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      print("Android SDK: ${androidInfo.version.sdkInt}");
      print("Android Release: ${androidInfo.version.release}");
    }
  }

  static Future<void> requestStoragePermission() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 30) {
        print("Requesting MANAGE_EXTERNAL_STORAGE permission");
        status = await Permission.manageExternalStorage.request();
      } else {
        print("Requesting STORAGE permission");
        status = await Permission.storage.request();
      }
    } else {
      // For iOS, use photos or media depending on usage
      status = await Permission.photos.request();
    }

    print("Permission status: $status");

    if (!status.isGranted) {
      throw Exception('Storage permission denied');
    }
  }

  static Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    print("Notification permission: $status");
  }
}

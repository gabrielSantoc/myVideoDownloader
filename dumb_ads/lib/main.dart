import 'package:dumb_ads/services/localPushService.dart';
import 'package:dumb_ads/services/permissionsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PermissionService.checkAndroidVersion();
  await LocalPushService.initLocalNotifications();
  await PermissionService.requestStoragePermission();
  await PermissionService.requestNotificationPermission();
  
  runApp( 
    const ProviderScope(
      child: App()
    )
  );
}


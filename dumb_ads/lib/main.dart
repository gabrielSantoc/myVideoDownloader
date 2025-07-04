import 'package:dumb_ads/services/localPushService.dart';
import 'package:dumb_ads/services/permissionsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await LocalPushService.initLocalNotifications();
    await PermissionService.requestNotificationPermission();
  } catch (e) {
    print("🟢 >>> Startup error: $e");
  }

  runApp( 
    const ProviderScope(
      child: App()
    )
  );
}


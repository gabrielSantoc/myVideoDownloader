import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class LocalPushService {

  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initSettings = InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          _onNotificationTapped(payload);
        }
      },
    );
  }

  static void _onNotificationTapped(String fileName) {
    final filePath = '/storage/emulated/0/Download/$fileName';
    OpenFilex.open(filePath);
  }

  static Future<void> showDownloadNotification({
    required int progress,
    required String fileName,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Shows progress of video downloads',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: 100,
      ongoing: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // notification ID
      'Downloading $fileName',
      '$progress%',
      notificationDetails,
      payload: fileName,
    );
  }

  static Future<void> completeDownloadNotification(String fileName) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Download completed',
      importance: Importance.high,
      priority: Priority.high,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      fileName,
      notificationDetails,
      payload: fileName
    );
  }

} 
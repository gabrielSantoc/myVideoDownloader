import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dumb_ads/features/home/domain/models/videoInfoModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';


final dio = Dio();
class VideoDownloaderService {
  static const String baseUrl = 'http://192.168.1.14:3000';

  static Future<VideoInfo> getVideoInfo({required String url}) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/v1/video/info',
        data: {
          'url': url,
        },
      );

      if (response.statusCode == 200) {
        print("🟢 ${response.data['info']}");
        return VideoInfo.fromJson(response.data['info']);
      } else {
        final errorMessage = response.data['error'] ?? 'Unknown error';
        print("ERROR: $errorMessage");
        throw Exception('API error (status ${response.statusCode}): $errorMessage');
      }

    } catch (e) {
      print("Exception during video info request: $e");
      throw Exception('Failed to get video info: $e');
    }
  }

  static Future<Map<String, dynamic>> downloadOnServer({
    required String url,
     String quality = "720",
    bool audioOnly = false,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/v1/video/download',
        data: {
          'url': url,
          'quality': quality,
          'audioOnly': audioOnly,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        final errorMessage = response.data['error'] ?? 'Unknown error';
        print("Error: $errorMessage");
        throw Exception(
          'API error during download (status ${response.statusCode}): $errorMessage',
        );
      }
    } catch (e) {
      print("Exception during download: $e");
      throw Exception('Download request failed: $e');
    }
  }

  static Future<void> downloadVideoToPhone({required String fileName}) async {
    final encodedName = Uri.encodeComponent(fileName);
    final url = '$baseUrl/api/v1/video/download/$encodedName';

    try {
      // Debug: Check Android version
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        print("Android SDK: ${androidInfo.version.sdkInt}");
        print("Android Release: ${androidInfo.version.release}");
      }

      // Request permission based on Android version
      PermissionStatus status;
      
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        
        if (androidInfo.version.sdkInt >= 30) {
          // Android 11+ (API 30+)
          print("Requesting MANAGE_EXTERNAL_STORAGE permission");
          status = await Permission.manageExternalStorage.request();
        } else {
          // Android 10 and below
          print("Requesting STORAGE permission");
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.photos.request();
      }

      print("Permission status: $status");
      
      if (!status.isGranted) {
        throw Exception('Storage permission denied');
      }

      // Rest of your download code...
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath = '${directory.path}/$fileName';

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      print("Video downloaded to: $filePath");

    } catch (e) {
      print("Failed to download video: $e");
      rethrow;
    }
  }
}
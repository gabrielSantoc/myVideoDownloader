import 'dart:io';
import 'package:dumb_ads/features/home/domain/models/videoFormatModel.dart';
import 'package:dumb_ads/features/home/domain/models/videoInfoModel.dart';
import 'package:dumb_ads/services/localPushService.dart';
import 'package:dio/dio.dart';
import 'package:dumb_ads/services/permissionsService.dart';


final dio = Dio();
class VideoDownloaderService {
  static const String baseUrl = 'http://192.168.1.3:3000';

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

    await PermissionService.checkAndroidVersion();
    await PermissionService.requestStoragePermission();

    try {

      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final filePath = '${directory.path}/$fileName';

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) async{
          if (total != -1) {
            final progress = (received / total * 100).toInt();
            print('Download progress: $progress%');

            await LocalPushService.showDownloadNotification(progress: progress, fileName: fileName);
          }
        },
      );
      await LocalPushService.completeDownloadNotification(fileName);

      print("Video downloaded to: $filePath");

    } catch (e) {
      print("Failed to download video: $e");
      rethrow;
    }
  }

  static Future<List<VideoFormat>> getQualitiesAndFormats({required String url}) async {

    try {
      final response = await dio.post(
        '$baseUrl/api/v1/video/info/quality-formats',
        data: {
          'url': url,
        }
      );

      if(response.statusCode == 200) {
        print("🟢 ${response.data['info']}");
        return VideoFormat.fromJsonList(response.data['availableFormats']);
      } else {
        final errorMessage = response.data['error'] ?? 'Unknown error';
        print("ERROR: $errorMessage");
        throw Exception('API error (status ${response.statusCode}): $errorMessage');
      }

    }catch(e) {
      print("Exception during download: $e");
      throw Exception('Failed getting video format: $e');
    }

  }

}
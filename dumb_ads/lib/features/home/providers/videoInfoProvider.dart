
import 'package:dumb_ads/features/home/domain/models/videoInfoModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoInfoCacheProvider = StateProvider<Map<String, VideoInfo>>((ref) => {});

final currentVideoInfoProvider = StateProvider<VideoInfo?>((ref) => null);

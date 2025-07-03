
import 'package:dumb_ads/features/home/providers/controllerProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clearButtonProvider = Provider<bool>((ref) {
  final urlTextController = ref.watch(urlControllerProvider);
  return urlTextController.text.isEmpty ? false : true;
});
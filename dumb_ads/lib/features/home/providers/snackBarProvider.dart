import 'package:dumb_ads/services/snackBarService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final snackBarServiceProvider = Provider<SnackBarService>((ref) {
  return SnackBarService(scaffoldMessengerKey);
});
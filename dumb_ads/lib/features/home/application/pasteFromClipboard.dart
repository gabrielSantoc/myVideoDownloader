

import 'package:dumb_ads/features/home/providers/clearButtonProvider.dart';
import 'package:dumb_ads/features/home/providers/controllerProvider.dart';
import 'package:dumb_ads/features/home/providers/snackBarProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> pasteText(WidgetRef ref) async {
  ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
  if(data != null && data.text != null) {
    final controller = ref.read(urlControllerProvider);
    controller.text = data.text!;
    ref.invalidate(clearButtonProvider);
  } else {
    final snackBarService = ref.watch(snackBarServiceProvider);
    snackBarService.showSnackBar("No text found in clipboard 😔");
    print("No text found in clipboard 😔");
  }
}
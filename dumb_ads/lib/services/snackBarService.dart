
import 'package:flutter/material.dart';

class SnackBarService {
  final GlobalKey<ScaffoldMessengerState> messengerKey;

  SnackBarService(this.messengerKey);

  void showSnackBar( String message ) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }

}
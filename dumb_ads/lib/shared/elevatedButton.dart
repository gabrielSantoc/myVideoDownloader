import 'package:dumb_ads/shared/constant.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({super.key, this.onTap, required this.buttonText});

  final void Function()? onTap;
  final String buttonText;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
      ),
      child:  Text(
        buttonText,
        style: const TextStyle(
          color: Color(TEXT_COLOR),
        ),
      )
    );
  }
}
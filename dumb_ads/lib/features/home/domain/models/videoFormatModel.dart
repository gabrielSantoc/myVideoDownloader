import 'package:flutter/material.dart';

class VideoFormat {
  final String quality;
  final String format;
  final String size;
  final String type;
  final IconData icon;
  final Color iconColor;

  VideoFormat({
    required this.quality,
    required this.format,
    required this.size,
    required this.type,
    required this.icon,
    required this.iconColor,
  });
}
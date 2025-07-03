import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({super.key, required this.thumbnailUrl});

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        thumbnailUrl, 
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(
            Icons.broken_image,
            color: Colors.grey
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2)
          );
        },
      ),
    );
  }
}
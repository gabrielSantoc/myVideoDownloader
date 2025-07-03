import 'package:dumb_ads/features/home/providers/clearButtonProvider.dart';
import 'package:dumb_ads/features/home/providers/controllerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TextFieldWidget extends ConsumerWidget {
  const TextFieldWidget({super.key, required this.hintText});

  final String hintText;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(urlControllerProvider);
    final showClearButton = ref.watch(clearButtonProvider);

    return TextField(
      onChanged: (_) {
        ref.invalidate(clearButtonProvider);
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        suffixIcon: showClearButton? IconButton(
          onPressed: () {
            controller.clear();
            ref.invalidate(clearButtonProvider);
          },
          icon:  const Icon(
            Icons.clear, size: 16,
            color: Colors.grey,
          )
        ): null,
      ),
    );
  }
}

import 'package:dumb_ads/features/home/application/pasteFromClipboard.dart';
import 'package:dumb_ads/features/home/providers/controllerProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dumb_ads/shared/elevatedButton.dart';
import 'package:dumb_ads/shared/constant.dart';
import 'package:dumb_ads/shared/textfield.dart';
import 'package:flutter/material.dart';

class VideoUrlCardWidget extends ConsumerWidget {
  const VideoUrlCardWidget({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlTextController = ref.watch(urlControllerProvider);
    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Video URL",
                style: TextStyle(
                  color: Color(TEXT_COLOR),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
          
              const SizedBox(height: 12),
              
              TextFieldWidget(
                controller: urlTextController,
                hintText: "Paste URL",
              ),
          
              const SizedBox(height: 12),
          
              SizedBox(
                width: double.infinity,
                child: ElevatedButtonWidget(
                  onTap: () => pasteText(ref),
                  buttonText: "Paste from cliboard",
                )
          
              )
            ],
          ),
        ),
      ),
    );
  }
}
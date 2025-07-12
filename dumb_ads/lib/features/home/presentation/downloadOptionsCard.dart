import 'package:dumb_ads/features/home/presentation/dialog.dart';
import 'package:dumb_ads/features/home/presentation/loadingDialog.dart';
import 'package:dumb_ads/features/home/providers/controllerProvider.dart';
import 'package:dumb_ads/features/home/providers/snackBarProvider.dart';
import 'package:dumb_ads/features/home/providers/videoFormatProvider.dart';
import 'package:dumb_ads/features/home/providers/videoInfoProvider.dart';
import 'package:dumb_ads/services/videoDownloaderService.dart';
import 'package:dumb_ads/shared/constant.dart';
import 'package:dumb_ads/shared/elevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadOptionsCardWidget extends ConsumerWidget {
  const DownloadOptionsCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                
              const Text(
                "Download Options",
                style: TextStyle(
                  color: Color(TEXT_COLOR),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
                
              const SizedBox(height: 12),
                
              SizedBox(
                width: double.infinity,
                child: ElevatedButtonWidget(
                  onTap: () async{
                    final controller = ref.read(urlControllerProvider);
                    final snackBarService = ref.watch(snackBarServiceProvider);
                    final url = controller.text.trim();

                    if(controller.text.isEmpty) {
                      snackBarService.showSnackBar("Link cannot be empty");
                      return;
                    }

                    final cache = ref.read(videoInfoCacheProvider);
                    final cachedInfo = cache[url];

                    if (cachedInfo != null) {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogWidget(),
                      );
                      return;
                    }

                    try {

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const LoadingDialog(text: "Fetching video details, please hold on...😁"),
                      );

                      final videoInfo = await VideoDownloaderService.getVideoInfo(url: url);
                      ref.read(currentVideoInfoProvider.notifier).state = videoInfo;

                      final availableVideoFormats = await VideoDownloaderService.getQualitiesAndFormats(url: url);
                      ref.read(videoFormatsProvider.notifier).state = availableVideoFormats;

                      print("🟢 Cached: $cache");
                      ref.read(videoInfoCacheProvider.notifier).state = {
                        ...cache,
                        url: videoInfo,
                      };
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const DialogWidget(),
                      );
                    } catch (e) {
                      snackBarService.showSnackBar("Failed to fetch video info: $e");
                    }

                  },
                  buttonText: "Get Download Options"
                )
              ),
                
              const Divider(
                height: 32,
              ),
                
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Supported Platform",
                      style: TextStyle(
                        color: Color(TEXT_COLOR),
                        fontWeight: FontWeight.w500
                      ),
                    ),
                
                    SizedBox(height: 8),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Facebook",
                          style: TextStyle(
                            color: Color(TEXT_COLOR),
                          ),
                        ),
                        Text(
                          "Instagram",
                          style: TextStyle(
                            color: Color(TEXT_COLOR),
                          ),
                        ),
                        Text(
                          "Tiktok",
                          style: TextStyle(
                            color: Color(TEXT_COLOR),
                          ),
                        ),
                        
                      ],
                    )
                  ],
                ),
              )
                
            ],
          ),
        ),
      ),
    );
  }
}
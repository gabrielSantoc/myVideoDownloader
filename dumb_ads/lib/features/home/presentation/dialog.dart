import 'package:dumb_ads/features/home/domain/models/videoFormatModel.dart';
import 'package:dumb_ads/features/home/presentation/thumbnail.dart';
import 'package:dumb_ads/features/home/providers/videoFormatProvider.dart';
import 'package:dumb_ads/features/home/providers/videoInfoProvider.dart';
import 'package:dumb_ads/services/videoDownloaderService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogWidget extends ConsumerWidget {
  const DialogWidget({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoInfo = ref.watch(currentVideoInfoProvider);
    final videoFormats = ref.watch(videoFormatsProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 400
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Download Options",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)
                  )
                ],
              ),
            ),

            // VIDEO INFO SECTION
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [

                  ThumbnailWidget(thumbnailUrl: videoInfo!.thumbnailUrl),

                  const SizedBox(width: 12),

                  // VIDEO DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoInfo.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          videoInfo.duration,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),

            //Format Options
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Choose Format & Quality',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: testFormats.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final format = videoFormats![index] ;
                          return InkWell(
                            onTap: () async {

                              try{
                                final downloadVideoFromServer = await VideoDownloaderService.downloadOnServer(
                                  url: videoInfo.videoUrl,
                                  quality: format.resolution
                                );
                                print( "🟢 >>> Video Downloaded Successfully In The Server" );
                                print( "🟢 >>> $downloadVideoFromServer" );
                              }catch(e) {
                                print("Error downloading video from the server: $e");
                              }                              

                              try{
                                final downloadVideoToPhone = await VideoDownloaderService.downloadVideoToPhone(
                                  fileName: '${videoInfo.title}.${format.extension}'
                                );
                                print("🟢 >>> Video Title: ${ videoInfo.title}${format.extension}");                                
                                print( "🟢 >>> Video Downloaded Successfully To the Phone" );
                              }catch(e) {
                                print("Error downloading video from the server: $e");
                              }


                            },
                            borderRadius: BorderRadius.circular(12),
                            
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.audiotrack,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          format.resolution,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${format.extension} • ${format.filesize}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.download,
                                    color: Colors.grey[400],
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      )
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

final testFormats = [
  VideoFormat(
    resolution: '1080',
    extension: 'MP4',
    filesize: '45.2 MB',
    type: 'video',

  ),
  VideoFormat(
    resolution: '1080',
    extension: 'MP4',
    filesize: '45.2 MB',
    type: 'video',

  ),
  VideoFormat(
    resolution: '1080',
    extension: 'MP4',
    filesize: '45.2 MB',
    type: 'video',

  ),
  VideoFormat(
    resolution: '1080',
    extension: 'MP4',
    filesize: '45.2 MB',
    type: 'video',

  ),
  // VideoFormat(
  //   quality: 'Audio Only',
  //   format: 'MP3',
  //   size: '3.8 MB',
  //   type: 'audio',
  //   icon: Icons.audiotrack,
  //   iconColor: Colors.green,
  // ),
  // VideoFormat(
  //   quality: 'Audio Only',
  //   format: 'M4A',
  //   size: '4.1 MB',
  //   type: 'audio',
  //   icon: Icons.audiotrack,
  //   iconColor: Colors.green,
  // ),
];




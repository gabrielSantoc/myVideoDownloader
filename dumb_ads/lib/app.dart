
import 'package:dumb_ads/features/home/presentation/appbar.dart';
import 'package:dumb_ads/features/home/presentation/downloadOptionsCard.dart';
import 'package:dumb_ads/features/home/presentation/videoUrlCard.dart';
import 'package:dumb_ads/features/home/providers/snackBarProvider.dart';
import 'package:dumb_ads/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const Scaffold(
        backgroundColor:Color(BACKGROUND_COLOR),
        appBar: AppbarWidget(),
        body: Column(
          children: [
            
            SizedBox(height: 20),
            
            VideoUrlCardWidget(),
      
            SizedBox(height: 18),
      
            DownloadOptionsCardWidget()
          ],
        )
      ),
    );
  }
}
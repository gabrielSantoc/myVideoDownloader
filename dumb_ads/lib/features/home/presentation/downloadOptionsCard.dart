import 'package:dumb_ads/features/home/presentation/dialog.dart';
import 'package:dumb_ads/shared/constant.dart';
import 'package:dumb_ads/shared/elevatedButton.dart';
import 'package:flutter/material.dart';

class DownloadOptionsCardWidget extends StatelessWidget {
  const DownloadOptionsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {

                    showDialog(
                      context: context,
                      builder: (context) => const DialogWidget()
                    );

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
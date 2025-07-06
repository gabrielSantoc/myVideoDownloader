import 'package:dumb_ads/shared/constant.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("DUMBADS"),
      // titleSpacing: -10,
      centerTitle: false,
      // leading: const Icon(Icons.arrow_downward_sharp),
      foregroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      backgroundColor: const Color(COLOR_BLUE),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

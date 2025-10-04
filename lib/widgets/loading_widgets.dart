import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/consts/assets_icons.dart';

class GridViewLoading extends StatelessWidget {
  const GridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Text(EmojiIcons.pan, style: TextStyle(fontSize: 80))
          Image.asset(AssetsIcons.pan, height: 100, width: 100)
              .animate(
                onComplete: (controller) => controller.repeat(reverse: true),
              )
              .slideY(duration: 1500.ms, curve: Curves.easeInOut),

          Text(
            "Preparing ...",
            style: GoogleFonts.instrumentSerif(
              textStyle: context.textTheme.bodyLarge,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              // fontFamily: "Fearless",
            ),
          ),
        ],
      ),
    );
  }
}

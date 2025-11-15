import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingLayoutWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Widget overlay;
  const LandingLayoutWidget({
    super.key,
    required this.title,
    required this.description,
    this.image = "",
    this.overlay = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: .center,
      children: [
        if (image.isNotEmpty)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(image, width: 280).animate().fadeIn(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.easeOut,
              ),
              overlay,
            ],
          ),

        Text(
          title,
          textAlign: .center,
          style: GoogleFonts.dmSerifText(
            height: 1,
            fontSize: 28,
            fontWeight: .bold,
          ),
        ),
        Text(
          description,
          textAlign: .center,
          style: GoogleFonts.inter(
            fontSize: 13,
            height: 1.8,
            color: context.colorScheme.onSurface.opaque(0.9),
            fontWeight: .w500,
          ),
        ),

        // if (image.isNotEmpty)
        //   const Spacer(),
      ],
    );
  }
}

import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
    required this.title,
    this.endSpacing = 0,
  });

  final String icon;
  final String title;
  final double endSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, width: 180).animate().scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          delay: 500.ms,
          duration: 2.seconds,
          curve: Curves.elasticOut,
        ),
        Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: context.theme.textTheme.bodyMedium,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                // fontStyle: FontStyle.italic,
              ),
            )
            .animate()
            .fadeIn(delay: 2.seconds),
        SizedBox(height: endSpacing),
      ],
    );
  }
}

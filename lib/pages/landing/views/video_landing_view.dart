import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes/consts/doodles_images.dart';
import 'package:recipes/consts/landing_images.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class VideoLandingView extends StatelessWidget {
  const VideoLandingView({super.key});

  @override
  Widget build(BuildContext context) {
        return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "More Visual?\nWe Got You",
          description:
              "Easily jump to the YouTube\nvideo tutorial for step-by-step\nguidance.",
          image: LandingImages.video,
          overlay: Positioned(
            bottom: 150,
            right: 0,
            child: SvgPicture.asset(DoodlesImages.video, width: 100),
          ),
        ),
      ),
    );
  }
}
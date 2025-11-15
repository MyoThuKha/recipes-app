import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes/consts/doodles_images.dart';
import 'package:recipes/consts/landing_images.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class DetailsLandingView extends StatelessWidget {
  const DetailsLandingView({super.key});

  @override
  Widget build(BuildContext context) {
        return SafeArea(
      child: Padding(
        padding: const .symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "Cook With Clarity",
          description:
              "Ingredients and instructions,\nclearly side-by-side for\neffortless preparation.",
          image: LandingImages.details,
          overlay: Positioned(
            bottom: 40,
            right: -55,
            child: SvgPicture.asset(DoodlesImages.details, width: 150),
          ),
        ),
      ),
    );
  }
}
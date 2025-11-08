import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes/consts/doodles_images.dart';
import 'package:recipes/consts/landing_images.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class CollectionsLandingView extends StatelessWidget {
  const CollectionsLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "Your Go-To\nFavorites",
          description: "Keep the dishes you love in\nyour personal library, ready\nwhenever you are.",
          image: LandingImages.collections,
          overlay: Positioned(
            bottom: 30,
            left: 55,
            child: SvgPicture.asset(DoodlesImages.circle, width: 80),
          ),
        ),
      ),
    );
  }
}
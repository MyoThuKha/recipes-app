import 'package:flutter/material.dart';
import 'package:recipes/consts/landing_images.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class IntroLandingView extends StatelessWidget {
  const IntroLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "Discover culinary delights",
          description:
              "Discover fuss-free recipes\nfrom a variety of cuisines, all in\none place.",
          image: LandingImages.discover,
        ),
      ),
    );
  }
}

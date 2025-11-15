import 'package:flutter/material.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class DoneLandingView extends StatelessWidget {
  const DoneLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: .symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "Done!",
          description:
              "You're all set and ready to explore the recipes.\n Hope you enjoy my first app.",
        ),
      ),
    );
  }
}

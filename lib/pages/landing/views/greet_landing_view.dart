import 'package:flutter/material.dart';
import 'package:recipes/pages/landing/widgets/landing_layout_widget.dart';

class GreetLandingView extends StatelessWidget {
  const GreetLandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: LandingLayoutWidget(
          title: "Hello!",
          description: "Welcome to the Recipes App. \n Let's get you started.",
        ),
      ),
    );
  }
}

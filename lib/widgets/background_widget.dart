import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "images/background.png",
        ),
        fit: BoxFit.fill,
      )
      ),
      child: child,
    );
  }
}

class AppBackground extends StatelessWidget {
  final Scaffold scaffold;
  const AppBackground({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(child: scaffold);
  }
}




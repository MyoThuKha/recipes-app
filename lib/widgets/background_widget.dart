import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Scaffold scaffold;
  const BackgroundWidget({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "images/background.png",
        ),
      )
      ),
      child: scaffold,
    );
  }
}
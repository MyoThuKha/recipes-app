import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Scaffold scaffold;
  const BackgroundWidget({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
        ])
      ),
      child: scaffold,
    );
  }
}
import 'package:flutter/material.dart';

class ColorOverlay extends StatelessWidget {
  final Color color;
  final Widget child;
  const ColorOverlay({super.key, required this.color, required this.child, });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ColoredBox(color: color),
        ),
      ],
    );
  }
}
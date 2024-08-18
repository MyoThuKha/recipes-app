import 'package:flutter/material.dart';

class OpacityAnimation extends StatelessWidget {
  final Widget child;
  const OpacityAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, _) {
          return Opacity(
            opacity: value,
            child: child,
          );
        });
  }
}

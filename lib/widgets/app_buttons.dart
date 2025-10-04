import 'package:flutter/material.dart';
import 'package:recipes/animations/scale_animation.dart';


class CircleBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  final Color background;
  final Color splash;
  const CircleBtn({super.key, required this.child, required this.onClick, this.background = Colors.white, this.splash = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      shape: const CircleBorder(),
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      splashColor: splash,
      fillColor: background,
      elevation: 0,
      padding: const EdgeInsets.all(10),
      onPressed: onClick,
      child: child,
    );
  }
}


class BackBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  const BackBtn({super.key, required this.child, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaleAnimation(
        onClick: onClick,
        child: InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 50,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
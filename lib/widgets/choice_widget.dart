import 'package:flutter/material.dart';
import 'package:recipes/animations/opacity_animation.dart';

class ChoiceWidget extends StatelessWidget {
  final String? label;
  final VoidCallback onClick;
  const ChoiceWidget({super.key, required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RawMaterialButton(
          onPressed: onClick,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          splashColor: Colors.purple,
          elevation: 0,
          fillColor: Colors.amber,
          child: Center(child: Text(label ?? "")),
        ),
      ),
    );
  }
}

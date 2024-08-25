import 'package:flutter/material.dart';
import 'package:recipes/widgets/dotted_border.dart';

class IngredientTile extends StatelessWidget {
  final String label;
  const IngredientTile({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomDashedLine(
        color: Colors.deepPurple[200]!,
        dashGap: 1.1,
        dashWidth: 5,
        dashHeight: 1.5,
      ),
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        width: double.infinity,
        child: Text(label)),
    );
  }
}

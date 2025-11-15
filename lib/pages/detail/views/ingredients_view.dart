import 'package:flutter/material.dart';
import 'package:recipes/models/ingredient_model.dart';
import 'package:recipes/widgets/dotted_border.dart';


class IngredientTile extends StatelessWidget {
  final IngredientModel ingredient;
  const IngredientTile({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return ingredient.name.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const .symmetric(
                  horizontal: 8,
                  vertical: 18,
                ),
                width: .infinity,
                child: Text(ingredient.name),
              ),

              CustomPaint(
                painter: BottomDashedLine(
                  color: Colors.deepPurple[200]!,
                  dashGap: 1.1,
                  dashWidth: 5,
                  dashHeight: 1.5,
                ),
                child: const SizedBox(height: 0, width: .infinity),
              ),
            ],
          );
  }
}
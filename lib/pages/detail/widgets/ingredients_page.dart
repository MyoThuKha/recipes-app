import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/models/ingredient_model.dart';
import 'package:recipes/providers/detail_page_provider.dart';
import 'package:recipes/widgets/dotted_border.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(
      builder: (context, model, _) {
        return Column(
          children: List.generate(model.ingredients.length, (index) {
            return IngredientTile(ingredient: model.ingredients[index]);
          }),
        );
      },
    );
  }
}

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 18,
                ),
                width: double.infinity,
                child: Text(ingredient.name),
              ),

              CustomPaint(
                painter: BottomDashedLine(
                  color: Colors.deepPurple[200]!,
                  dashGap: 1.1,
                  dashWidth: 5,
                  dashHeight: 1.5,
                ),
                child: const SizedBox(height: 0, width: double.infinity),
              ),
            ],
          );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/detail/widgets/ingredient_tile.dart';
import 'package:recipes/providers/detail_page_provider.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(builder: (context, model, _) {
      return Column(
        children: List.generate(
          model.ingredients.length,
          (index) {
            return IngredientTile(ingredient: model.ingredients[index]);
          },
        ),
      );
    });
  }
}

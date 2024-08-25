import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/pages/detail/widgets/ingredient_tile.dart';
import 'package:recipes/providers/detail_page_provider.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {

  @override
  void initState() {
    //TODO format ingredients to list
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageProvider>(
      builder: (context, model,_) {
        return Column(
          children: List.generate(
            20,
            (context) => IngredientTile(label: model.meal?.strIngredient1 ?? ""),
          ),
        );
      }
    );
  }
}
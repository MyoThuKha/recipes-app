import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes/models/meal_list_model.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Uri(path: '/detail/${meal.idMeal}').toString());
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(image: NetworkImage(meal.strMealThumb ?? "")),
            ),
            alignment: Alignment.center,
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: Text(
                  meal.strMeal ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

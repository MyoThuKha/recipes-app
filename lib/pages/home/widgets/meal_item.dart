import 'package:cached_network_image/cached_network_image.dart';
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
            color: Colors.deepPurple[400],
              borderRadius: BorderRadius.circular(30),
              // image: DecorationImage(
              //   image: NetworkImage(
              //     meal.strMealThumb ?? "",
              //   ),
              // ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  meal.strMealThumb ?? "",
                ),
              ),
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
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(4),
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Text(
                  meal.strMeal ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
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

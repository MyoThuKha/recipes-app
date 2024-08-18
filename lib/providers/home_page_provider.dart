import 'package:flutter/material.dart';
import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/network/network_manager.dart';

class HomePageProvider extends ChangeNotifier{
  List<String> categories = [];
  List<Meal> meals = [];

  String currCategory = "";


  Future<void> getCategories() async {
    final result = await NetworkManager.shared.getCategories();

    if (result is SuccessResponseModel) {
      final convertedResult = result.data as CategoryModel;
      categories = convertedResult.meals ?? [];
    } else {
      failureCase(result);
    }
    notifyListeners();
  }

  void getMealsByCategory(String category) async {

    if (currCategory == category){
      print("already page");
      return;
    }
    currCategory = category;

    final result = await NetworkManager.shared.getMealsByCategories(category);

    if (result is SuccessResponseModel) {
      final convertedResult = result.data as MealListModel;
      meals = convertedResult.meals ?? [];
    } else {
      failureCase(result);
    }
    notifyListeners();
  }


  void failureCase(ResponseModel result) {
      final res = result as ErrorResponseModel;
      print("Failure ----- ");
      print(res.message);
  }
}
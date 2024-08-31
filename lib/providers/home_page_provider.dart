import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';

class HomePageProvider extends BaseProvider {
  List<String> categories = [];
  List<Meal> meals = [];

  bool isLoading = false;

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
      return;
    }
    currCategory = category;

    isLoading = true;

    final result = await NetworkManager.shared.getMealsByCategories(category);

    if (result is SuccessResponseModel) {
      final convertedResult = result.data as MealListModel;
      meals = convertedResult.meals ?? [];
    } else {
      failureCase(result);
    }
    isLoading = false;
    notifyListeners();
  }


}
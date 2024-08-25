import 'package:recipes/models/ingredient_model.dart';
import 'package:recipes/models/meal_detail_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';

class DetailPageProvider extends BaseProvider {
  MealDetail? meal;
  List<IngredientModel> ingredients = [];

  void getMealDetail(String id) async {
    meal = null;
    final result = await NetworkManager.shared.getMealDetail(id);

    if (result is SuccessResponseModel) {
      final data = result.data as MealDetailModel;
      meal = data.meals?[0];
      ingredients = data.meals?[0].ingredients ?? [];
    } else {
      failureCase(result);
    }
    notifyListeners();
  }


}

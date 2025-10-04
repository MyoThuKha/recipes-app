import 'package:recipes/models/ingredient_model.dart';
import 'package:recipes/models/meal_detail_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/widgets/fab_btn.dart';

class DetailPageProvider extends BaseProvider {
  MealDetail? meal;
  Content currentContent = Content.instructions;
  List<IngredientModel> ingredients = [];


  set updateContent(Content content) {
    currentContent = content;
    notifyListeners();
  }

  void getMealDetail(String id) async {
    clear();
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

  void getRandomMeal() async {
    clear();
    final result = await NetworkManager.shared.getRandomMeal();

    if (result is SuccessResponseModel) {
      final data = result.data as MealDetailModel;
      meal = data.meals?[0];
      ingredients = data.meals?[0].ingredients ?? [];
    } else {
      failureCase(result);
    }
    notifyListeners();
  }

  void clear() {
    meal = null;
    ingredients.clear();
  }

}

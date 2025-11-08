import 'package:collection/collection.dart';
import 'package:recipes/entities/collection_entity.dart';
import 'package:recipes/injector.dart';
import 'package:recipes/models/ingredient_model.dart';
import 'package:recipes/models/meal_detail_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/models/status_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/storage/storage_manager.dart';
import 'package:recipes/widgets/fab_btn.dart';

class DetailPageProvider extends BaseProvider {
  MealDetail? meal;
  Content currentContent = Content.instructions;
  List<String> tags = [];
  List<IngredientModel> ingredients = [];

  set updateContent(Content content) {
    currentContent = content;
    notifyListeners();
  }

  Future<void> getMealDetail(String id) async {
    clear();
    final result = await NetworkManager.shared.getMealDetail(id);

    if (result is SuccessResponseModel) {
      final data = result.data as MealDetailModel;
      meal = data.meals?[0];
      ingredients = data.meals?[0].ingredients ?? [];
      extractTags(data.meals?[0].strTags ?? "");
    } else {
      failureCase(result);
    }
    notifyListeners();
  }

  void extractTags(String strVal) {
    final list = strVal.split(",");
    list.removeWhere((element) => element.isEmpty);
    tags = list;
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


  Future<StatusModel> addToCollection() async {
    final collections = await getIt.get<StorageManager>().readAll<CollectionEntity>();

    final existingEntity = collections.firstWhereOrNull(
      (element) => element.idMeal == meal?.idMeal,
    );

    final newMeal = CollectionEntity(
      id: existingEntity?.id ?? 0,
      idMeal: meal?.idMeal,
      strMeal: meal?.strMeal,
      strMealThumb: meal?.strMealThumb,
    );

    await getIt.get<StorageManager>().update<CollectionEntity>(newMeal);

    // meal existed
    if (existingEntity != null) {
      return SuccessModel(
        status: Status.success,
        message: "Already in collection. We updated it for you.",
      );
    }

    return SuccessModel(
      status: Status.success,
      message: "Dish is now ready in your collection.",
    );
  }

  void clear() {
    meal = null;
    ingredients.clear();
  }

}

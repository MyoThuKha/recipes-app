import 'package:collection/collection.dart';
import 'package:recipes/entities/collection_entity.dart';
import 'package:recipes/injector.dart';
import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/models/status_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/storage/storage_manager.dart';

class HomePageProvider extends BaseProvider {
  List<String> categories = [];
  List<Meal> meals = [];
  List<CollectionEntity> collections = [];

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
    if (currCategory == category) {
      return;
    }

    currCategory = category;

    isLoading = true;

    // final result = await NetworkManager.shared.getMealsByCategories(category);
    final data = NetworkManager.shared.getMealsByCategories(category);

    await Future.wait([
      data,
      Future.delayed(const Duration(milliseconds: 1000)),
    ]);

    final result = await data;

    if (result is SuccessResponseModel) {
      final convertedResult = result.data as MealListModel;
      meals = convertedResult.meals ?? [];
    } else {
      failureCase(result);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadAllLocalDishes() async {
    final result = await getIt
        .get<StorageManager>()
        .readAll<CollectionEntity>();
    collections = result;
    notifyListeners();
  }

  // {
  //   "status": "success",
  //   "message": "Meal added to collection",
  // }

  Future<StatusModel> addToCollection(Meal meal) async {
    final existingEntity = collections.firstWhereOrNull(
      (element) => element.idMeal == meal.idMeal,
    );

    // meal existed
    if (existingEntity != null) {
      existingEntity.idMeal = meal.idMeal;
      existingEntity.strMeal = meal.strMeal;
      existingEntity.strMealThumb = meal.strMealThumb;

      await getIt.get<StorageManager>().update<CollectionEntity>(
        existingEntity,
      );
      return SuccessModel(
        status: Status.success,
        message: "Already in collection. We updated it for you.",
      );
    }

    // meal is new.
    final entity = CollectionEntity();

    entity.idMeal = meal.idMeal;
    entity.strMeal = meal.strMeal;
    entity.strMealThumb = meal.strMealThumb;

    await getIt.get<StorageManager>().create<CollectionEntity>(entity);
    collections.add(entity);
    return SuccessModel(
      status: Status.success,
      message: "Dish is now ready in your collection.",
    );
  }
}

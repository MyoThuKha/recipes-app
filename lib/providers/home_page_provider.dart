import 'package:recipes/entities/collection_entity.dart';
import 'package:recipes/injector.dart';
import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';
import 'package:recipes/network/network_manager.dart';
import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/storage/storage_manager.dart';

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


  Future<void> addToCollection(Meal meal) async {
    final entity = CollectionEntity();

    entity.idMeal = meal.idMeal;
    entity.strMeal = meal.strMeal;
    entity.strMealThumb = meal.strMealThumb;

    final result = await getIt.get<StorageManager>().update<CollectionEntity>(entity);

  }


}
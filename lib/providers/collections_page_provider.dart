import 'package:recipes/entities/collection_entity.dart';
import 'package:recipes/injector.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/storage/storage_manager.dart';

class CollectionsPageProvider extends BaseProvider {
  List<Meal> meals = [];
  List<CollectionEntity> collections = [];

  bool isLoading = false;

  String currCategory = "";

  void getLocalDishes() async {
    isLoading = true;

    final data = getIt.get<StorageManager>().readAll<CollectionEntity>();

    await Future.wait([data]);

    collections = await data;

    if (collections.isNotEmpty) {
      final convertedResult = collections.map((e) => Meal.fromEntity(e)).toList();
      meals = convertedResult;
    } else {}
    isLoading = false;
    notifyListeners();
  }


  void remove(Meal meal) async {
    final result = collections.firstWhere((element) => element.idMeal == meal.idMeal);
    await getIt.get<StorageManager>().delete(result.id);
    collections.remove(result);
    meals.removeWhere((element) => element.idMeal == meal.idMeal);
    notifyListeners();
  }
}

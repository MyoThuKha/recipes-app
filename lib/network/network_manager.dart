import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_detail_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';

const version = String.fromEnvironment("version");
const apiKey = String.fromEnvironment("key");
const _path = "/api/json/$version/$apiKey";

class NetworkManager {
  final baseUrl = "www.themealdb.com";
  static final shared = NetworkManager();

  Future<ResponseModel> getCategories() async {
    const endpoint = "$_path/list.php";
    final uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: endpoint,
      queryParameters: {"c": "list"},
    );

    final result = await http.get(uri);

    if (result.statusCode == 200) {
      return SuccessResponseModel(
        code: result.statusCode,
        data: CategoryModel.fromJson(jsonDecode(result.body)),
      );
    }
    return ErrorResponseModel(code: result.statusCode, message: result.body);
  }

  Future<ResponseModel> getMealsByCategories(String category) async {
    const endpoint = "$_path/filter.php";
    final uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: endpoint,
      queryParameters: {"c": category},
    );

    final result = await http.get(uri);

    if (result.statusCode == 200) {
      return SuccessResponseModel(code: result.statusCode, data: MealListModel.fromJson(jsonDecode(result.body)));
    }
    return ErrorResponseModel(code: result.statusCode, message: result.body);
  }

  Future<ResponseModel> getMealDetail(String mealId) async {
    const endpoint = "$_path/lookup.php";
    final uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: endpoint,
      queryParameters: {"i": mealId},
    );

    final result = await http.get(uri);

    if (result.statusCode == 200) {
      return SuccessResponseModel(code: result.statusCode, data: MealDetailModel.fromJson(jsonDecode(result.body)));
    }
    return ErrorResponseModel(code: result.statusCode, message: result.body);
  }

  Future<ResponseModel> getRandomMeal() async {
    const endpoint = "$_path/random.php";
    // TODO extract same things
    final uri = Uri(
      scheme: "https",
      host: baseUrl,
      path: endpoint,
    );

    final result = await http.get(uri);

    if (result.statusCode == 200) {
      return SuccessResponseModel(code: result.statusCode, data: MealDetailModel.fromJson(jsonDecode(result.body)));
    }
    return ErrorResponseModel(code: result.statusCode, message: result.body);
  }
}

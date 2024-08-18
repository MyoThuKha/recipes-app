import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipes/models/category_model.dart';
import 'package:recipes/models/meal_list_model.dart';
import 'package:recipes/models/response_model.dart';
enum Status {loading, success, error}

class NetworkManager {
  final baseUrl = "www.themealdb.com";
  static final shared = NetworkManager();


  Future<ResponseModel> getCategories()async{
    const endpoint = "/api/json/v1/1/list.php";
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
    return ErrorResponseModel(code: result.statusCode,message: result.body);
  }


  Future<ResponseModel> getMealsByCategories(String category) async {
    const endpoint = "/api/json/v1/1/filter.php";
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

}
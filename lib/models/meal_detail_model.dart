import 'package:recipes/models/ingredient_model.dart';

class MealDetailModel {
  List<MealDetail>? meals;

  MealDetailModel({this.meals});

  MealDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <MealDetail>[];
      json['meals'].forEach((v) {
        meals!.add(MealDetail.fromJson(v));
      });
    }
  }
}

class MealDetail {
  String? idMeal;
  String? strMeal;
  String? strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  List<IngredientModel>? ingredients;
  String? strSource;
  String? strImageSource;
  String? strCreativeCommonsConfirmed;
  String? dateModified;

  MealDetail(
      {this.idMeal,
      this.strMeal,
      this.strDrinkAlternate,
      this.strCategory,
      this.strArea,
      this.strInstructions,
      this.strMealThumb,
      this.strTags,
      this.strYoutube,
      this.ingredients,
      this.strSource,
      this.strImageSource,
      this.strCreativeCommonsConfirmed,
      this.dateModified});

  MealDetail.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strDrinkAlternate = json['strDrinkAlternate'];
    strCategory = json['strCategory'];
    strArea = json['strArea'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
    strYoutube = json['strYoutube'];
    ingredients = List.generate(20, (index) {
      return IngredientModel(name: json["strIngredient${index + 1}"] ?? "", measurement: json['strMeasure${index + 1}'] ?? "");
    });
    strSource = json['strSource'];
    strImageSource = json['strImageSource'];
    strCreativeCommonsConfirmed = json['strCreativeCommonsConfirmed'];
    dateModified = json['dateModified'];
  }
}

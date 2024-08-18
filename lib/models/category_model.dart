class CategoryModel {
  List<String>? meals;

  CategoryModel({this.meals});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] == null) {
      return;
    }

    final categoryList = json["meals"] as List;

    meals = categoryList.map((each) => each["strCategory"].toString()).toList();
  }

}


import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String categoryName;
  List<String> caterorySub;

  Category({
    required this.categoryName,
    required this.caterorySub,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["category_name"],
        caterorySub: List<String>.from(json["caterory_sub"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "caterory_sub": List<dynamic>.from(caterorySub.map((x) => x)),
      };
}

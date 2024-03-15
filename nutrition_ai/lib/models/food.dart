import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';
import 'ingredient.dart';

class FoodModel {
  final String code;
  final String name;
  final String description;
  final CategoryModel category;
  List<IngredientModel>? ingredients;
  String? image;

  FoodModel({
    required this.code,
    required this.name,
    required this.description,
    required this.category,
    this.ingredients,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'category': category.toJson(),
      'ingredients':
          ingredients?.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      code: map['code'],
      name: map['name'],
      description: map['description'],
      category: CategoryModel.fromMap(map['category']),
      ingredients: map['ingredients']
          .map<IngredientModel>(
              (ingredient) => IngredientModel.fromMap(ingredient))
          .toList(),
    );
  }

  FoodModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : code = snapshot['code'],
        name = snapshot['name'],
        description = snapshot['description'],
        category = CategoryModel.fromMap(snapshot['category']),
        ingredients = snapshot['ingredients']
            .map<IngredientModel>(
                (ingredient) => IngredientModel.fromMap(ingredient))
            .toList();
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';
import 'ingredient.dart';

class FoodModel {
  final int code;
  final String name;
  final String description;
  final CategoryModel category;
  List<IngredientModel>? ingredients;

  FoodModel({
    required this.code,
    required this.name,
    required this.description,
    required this.category,
    this.ingredients,
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

  FoodModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : code = snapshot['code'],
        name = snapshot['name'],
        description = snapshot['description'],
        category = CategoryModel.fromMap(snapshot['category']),
        ingredients = snapshot['ingredients']
            .map<IngredientModel>((ingredient) =>
                IngredientModel.fromMap(ingredient))
            .toList();
}

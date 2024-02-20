import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';
import 'ingredient.dart';

class FoodModel {
  final int code;
  final String name;
  final String description;
  final String? image;
  final CategoryModel category;
  List<IngredientModel>? ingredients;

  FoodModel({
    required this.code,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'image': image,
      'category': category.toJson(),
      'ingredients':
          ingredients?.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  FoodModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : code = snapshot['code'],
        name = snapshot['name'],
        description = snapshot['description'],
        image = snapshot['image'],
        category = CategoryModel.fromMap(snapshot['category']),
        ingredients = snapshot['ingredients']
            .map<IngredientModel>((ingredient) =>
                IngredientModel.fromDocumentSnapshot(ingredient))
            .toList();
}

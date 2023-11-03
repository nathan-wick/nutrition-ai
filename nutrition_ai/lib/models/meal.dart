import 'ingredient.dart';

class MealModel {
  final String name;
  final String photo;
  String? instruction;
  List<IngredientModel>? ingredients;

  MealModel({
    required this.name,
    required this.photo,
    this.instruction,
    this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'instruction': instruction,
      'ingredients': ingredients?.map((ingredient) => ingredient.toJson()).toList(),
      'photo': photo,
    };
  }
}
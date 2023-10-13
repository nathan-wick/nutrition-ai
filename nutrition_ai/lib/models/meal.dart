import 'ingredient.dart';

class Meal {
  final String name;
  final String instruction;
  final List<Ingredient> ingredients;

  Meal({
    required this.name,
    required this.instruction,
    required this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'instruction': instruction,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
  
}
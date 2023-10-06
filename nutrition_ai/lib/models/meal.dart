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
}
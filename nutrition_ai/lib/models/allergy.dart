import 'ingredient.dart';

class Allergy {
  final String name;
  final List<Ingredient> relatedIngredients;

  Allergy({
    required this.name,
    required this.relatedIngredients,
  });
}
import 'ingredient.dart';

class Allergy {
  final String name;
  final List<Ingredient> relatedIngredients;

  Allergy({
    required this.name,
    required this.relatedIngredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relatedIngredients': relatedIngredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
  
}
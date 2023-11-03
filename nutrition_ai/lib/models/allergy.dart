import 'ingredient.dart';

class AllergyModel {
  final String name;
  final List<IngredientModel> relatedIngredients;

  AllergyModel({
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
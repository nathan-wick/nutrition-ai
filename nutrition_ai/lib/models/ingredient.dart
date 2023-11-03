import 'measurement.dart';
import 'part.dart';

class IngredientModel {
  final String name;
  final String amount;
  final List<PartModel>? parts;

  IngredientModel({
    required this.name,
    required this.amount,
    this.parts,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'parts': parts?.map((part) => part.toJson()).toList(),
    };
  }
}

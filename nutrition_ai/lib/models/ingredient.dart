import 'measurement.dart';
import 'part.dart';

class Ingredient {
  final String name;
  final Measurement amount;
  final List<Part> parts;

  Ingredient({
    required this.name,
    required this.amount,
    required this.parts,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount.toJson(),
      'parts': parts.map((part) => part.toJson()).toList(),
    };
  }
}
import 'measurement.dart';
import 'part.dart';

class Ingredient {
  final String name;
  final String amount;
  final List<Part>? parts;

  Ingredient({
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

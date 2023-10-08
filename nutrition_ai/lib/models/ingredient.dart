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
}
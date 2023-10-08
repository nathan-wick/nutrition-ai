import 'measurement.dart';
import 'nutrient.dart';

class Part {
  final Nutrient nutrient;
  final Measurement amount;

  Part({
    required this.nutrient,
    required this.amount,
  });
}
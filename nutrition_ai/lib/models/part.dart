import 'measurement.dart';
import 'nutrient.dart';

class PartModel {
  final NutrientModel nutrient;
  final MeasurementModel amount;

  PartModel({
    required this.nutrient,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'nutrient': nutrient.toJson(),
      'amount': amount.toJson(),
    };
  }
}
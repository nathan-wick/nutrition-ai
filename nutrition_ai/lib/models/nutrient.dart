import 'measurement.dart';

class NutrientModel {
  final String name;
  final int code;
  final String description;
  final MeasurementModel? amount;
  final String? defaultMeasurementUnit;

  NutrientModel({
    required this.name,
    required this.code,
    required this.description,
    this.amount,
    this.defaultMeasurementUnit,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'amount': amount?.toJson(),
      'defaultMeasurementUnit': defaultMeasurementUnit,
    };
  }
}

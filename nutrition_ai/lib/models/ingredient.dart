import 'package:cloud_firestore/cloud_firestore.dart';

import 'measurement.dart';
import 'nutrient.dart';

class IngredientModel {
  final int code;
  final String name;
  final double moistureChange;
  final double retentionCode;
  final MeasurementModel amount;
  final List<NutrientModel> nutrients;

  IngredientModel({
    required this.code,
    required this.name,
    required this.moistureChange,
    required this.retentionCode,
    required this.amount,
    required this.nutrients,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'moistureChange': moistureChange,
      'retentionCode': retentionCode,
      'amount': amount,
      'nutrients': nutrients.map((nutrient) => nutrient.toJson()).toList(),
    };
  }

  IngredientModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : code = snapshot['code'],
        name = snapshot['name'],
        moistureChange = snapshot['moistureChange'],
        retentionCode = snapshot['retentionCode'],
        amount = snapshot['amount'],
        nutrients = snapshot['nutrients']
            .map<NutrientModel>(
                (nutrient) => NutrientModel.fromDocumentSnapshot(nutrient))
            .toList();
}

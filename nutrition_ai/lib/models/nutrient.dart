import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory NutrientModel.fromMap(Map<String, dynamic> map) {
    return NutrientModel(
      name: map['name'],
      code: map['code'],
      description: map['description'],
      amount: MeasurementModel.fromMap(map['amount']),
      defaultMeasurementUnit: map['defaultMeasurementUnit'],
    );
  }

  NutrientModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        code = snapshot['code'],
        description = snapshot['description'],
        amount = MeasurementModel.fromMap(snapshot['amount']),
        defaultMeasurementUnit = snapshot['defaultMeasurementUnit'];
}

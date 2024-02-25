import 'package:cloud_firestore/cloud_firestore.dart';

import 'measurement.dart';

class NutrientModel {
  final String name;
  final int code;
  final MeasurementModel? amount;
  final String? defaultMeasurementUnit;

  NutrientModel({
    required this.name,
    required this.code,
    this.amount,
    this.defaultMeasurementUnit,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'amount': amount?.toJson(),
      'defaultMeasurementUnit': defaultMeasurementUnit,
    };
  }

  factory NutrientModel.fromMap(Map<String, dynamic> map) {
    return NutrientModel(
      name: map['name'],
      code: map['code'],
      amount: MeasurementModel.fromMap(map['amount']),
      defaultMeasurementUnit: map['defaultMeasurementUnit'],
    );
  }

  NutrientModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        code = snapshot['code'],
        amount = MeasurementModel.fromMap(snapshot['amount']),
        defaultMeasurementUnit = snapshot['defaultMeasurementUnit'];
}

import 'package:cloud_firestore/cloud_firestore.dart';

class MeasurementModel {
  final double amount;
  final String unit;

  MeasurementModel({
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit,
    };
  }

  factory MeasurementModel.fromMap(Map<String, dynamic> map) {
    return MeasurementModel(
      amount: map['amount'].toDouble(),
      unit: map['unit'],
    );
  }

  MeasurementModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : amount = snapshot['amount'],
        unit = snapshot['unit'];
}

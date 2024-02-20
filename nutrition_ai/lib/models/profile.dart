import 'package:cloud_firestore/cloud_firestore.dart';

import 'measurement.dart';

class ProfileModel {
  DateTime birthday;
  String sex;
  MeasurementModel height;
  MeasurementModel weight;
  String exerciseFrequency;
  String goal;
  final int? age;
  final double? bodyMassIndex;
  final double? totalDailyEnergyExpenditure;

  ProfileModel({
    required this.birthday,
    required this.sex,
    required this.height,
    required this.weight,
    required this.exerciseFrequency,
    required this.goal,
    this.age,
    this.bodyMassIndex,
    this.totalDailyEnergyExpenditure,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday,
      'sex': sex,
      'height': height.toJson(),
      'weight': weight.toJson(),
      'exerciseFrequency': exerciseFrequency,
      'goal': goal,
      'age': age,
      'bodyMassIndex': bodyMassIndex,
      'totalDailyEnergyExpenditure': totalDailyEnergyExpenditure,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      birthday: map['birthday'].toDate(),
      sex: map['sex'],
      height: MeasurementModel.fromMap(map['height']),
      weight: MeasurementModel.fromMap(map['weight']),
      exerciseFrequency: map['exerciseFrequency'],
      goal: map['goal'],
      age: map['age'],
      bodyMassIndex: map['bodyMassIndex'],
      totalDailyEnergyExpenditure: map['totalDailyEnergyExpenditure'],
    );
  }

  ProfileModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : birthday = DateTime.fromMillisecondsSinceEpoch(snapshot['birthday']),
        sex = snapshot['sex'],
        height = snapshot['height'],
        weight = snapshot['weight'],
        exerciseFrequency = snapshot['exerciseFrequency'],
        goal = snapshot['goal'],
        age = snapshot['age'],
        bodyMassIndex = snapshot['bodyMassIndex'],
        totalDailyEnergyExpenditure = snapshot['totalDailyEnergyExpenditure'];
}

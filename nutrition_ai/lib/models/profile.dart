import 'measurement.dart';

class ProfileModel {
  final DateTime birthday;
  final String sex;
  final MeasurementModel height;
  final MeasurementModel weight;
  final String exerciseFrequency;
  final String goal;
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
      'height': height,
      'weight': weight,
      'exerciseFrequency': exerciseFrequency,
      'goal': goal,
      'age': age,
      'bodyMassIndex': bodyMassIndex,
      'totalDailyEnergyExpenditure': totalDailyEnergyExpenditure,
    };
  }
}

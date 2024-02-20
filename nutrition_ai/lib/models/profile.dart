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

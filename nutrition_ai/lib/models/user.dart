import 'allergy.dart';
import 'habit.dart';
import 'ingredient.dart';
import 'measurement.dart';

enum UserSex {
  xx,
  xy,
}

class User {
  final String name;
  final String email;
  final DateTime birthday;
  final UserSex sex;
  final Measurement height;
  final Measurement weight;
  final List<Habit> habits;
  final List<Allergy> allergies;
  final List<Ingredient> approvedIngredients;
  final List<Ingredient> rejectedIngredients;

  User({
    required this.name,
    required this.email,
    required this.birthday,
    required this.sex,
    required this.height,
    required this.weight,
    required this.habits,
    required this.allergies,
    required this.approvedIngredients,
    required this.rejectedIngredients,
  });
}
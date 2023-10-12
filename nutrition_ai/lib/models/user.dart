import 'allergy.dart';
import 'habit.dart';
import 'ingredient.dart';
import 'measurement.dart';
import 'goal.dart';

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
  final Goal goal;
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
    required this.goal,
    required this.allergies,
    required this.approvedIngredients,
    required this.rejectedIngredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'email' : email,
      'birthday' : birthday,
      'sex' : sex.toString().split('.').last,
      'height' : height.toJson(),
      'weight' : weight.toJson(),
      'goal' : goal.toJson(),
      'allergies': allergies.map((allergy) => allergy.toJson()).toList(),
      'approvedIngredients': approvedIngredients.map((ingredient) => ingredient.toJson()).toList(),
      'rejectedIngredients': rejectedIngredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

}
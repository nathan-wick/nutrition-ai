import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String photo;
  final DateTime? birthday;
  final UserSex? sex;
  final Measurement? height;
  final Measurement? weight;
  final List<Habit>? habits;
  final Goal? goal;
  final List<Allergy>? allergies;
  final List<Ingredient>? approvedIngredients;
  final List<Ingredient>? rejectedIngredients;

  User({
    required this.name,
    required this.email,
    required this.photo,
    this.birthday,
    this.sex,
    this.height,
    this.weight,
    this.habits,
    this.goal,
    this.allergies,
    this.approvedIngredients,
    this.rejectedIngredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'photo': photo,
      'birthday': birthday,
      'sex': sex?.toString().split('.').last,
      'height': height?.toJson(),
      'weight': weight?.toJson(),
      'habits': habits?.map((habit) => habit.toJson()).toList(),
      'goal': goal?.toJson(),
      'allergies': allergies?.map((allergy) => allergy.toJson()).toList(),
      'approvedIngredients': approvedIngredients?.map((ingredient) => ingredient.toJson()).toList(),
      'rejectedIngredients': rejectedIngredients?.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

// factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//     return User(
// //ame = snapshot['name'],
//       email = snapshot['email'],      
//       photo = snapshot['photo'],
//       birthday = snapshot['birthday'],
//       sex = snapshot['sex'],
//       height = snapshot['height'],
//       weight = snapshot['weight'],
//       habits = snapshot['habits'],
//       goal = snapshot['goal'],
//       allergies = snapshot['allergies'],
//       approvedIngredients = snapshot['approvedIngredients'],
//       rejectedIngredients = snapshot['rejectedIngredients'];
//   ;
    User.fromDocumentSnapshot(DocumentSnapshot snapshot) 
     :name = snapshot['name'],
      email = snapshot['email'],
      photo = snapshot['photo'],
      birthday = snapshot['birthday'],
      sex = snapshot['sex'],
      height = snapshot['height'],
      weight = snapshot['weight'],
      habits = snapshot['habits'],
      goal = snapshot['goal'],
      allergies = snapshot['allergies'],
      approvedIngredients = snapshot['approvedIngredients'],
      rejectedIngredients = snapshot['rejectedIngredients'];
}
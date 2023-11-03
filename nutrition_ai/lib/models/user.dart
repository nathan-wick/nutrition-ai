import 'package:cloud_firestore/cloud_firestore.dart';

import 'allergy.dart';
import 'ingredient.dart';

class UserModel {
  final String email;
  DateTime birthday;
  String sex;
  double heightInches;
  double weightPounds;
  String exerciseFrequency;
  String goal;
  String? name;
  String? photo;
  List<AllergyModel>? allergies;
  List<IngredientModel>? approvedIngredients;
  List<IngredientModel>? rejectedIngredients;

  UserModel({
    required this.email,
    required this.birthday,
    required this.sex,
    required this.heightInches,
    required this.weightPounds,
    required this.exerciseFrequency,
    required this.goal,
    this.name,
    this.photo,
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
      'sex': sex,
      'heightInches': heightInches,
      'weightPounds': weightPounds,
      'exerciseFrequency': exerciseFrequency,
      'goal': goal,
      'allergies': allergies?.map((allergy) => allergy.toJson()).toList(),
      'approvedIngredients': approvedIngredients?.map((ingredient) => ingredient.toJson()).toList(),
      'rejectedIngredients': rejectedIngredients?.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
  
  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) :
    name = snapshot['name'],
    email = snapshot['email'],
    photo = snapshot['photo'],
    birthday = snapshot['birthday'].toDate(),
    sex = snapshot['sex'],
    heightInches = snapshot['heightInches'],
    weightPounds = snapshot['weightPounds'],
    exerciseFrequency = snapshot['exerciseFrequency'],
    goal = snapshot['goal'],
    allergies = snapshot['allergies'],
    approvedIngredients = snapshot['approvedIngredients'],
    rejectedIngredients = snapshot['rejectedIngredients'];
}
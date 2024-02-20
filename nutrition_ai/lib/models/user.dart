import 'package:cloud_firestore/cloud_firestore.dart';
import 'food.dart';
import 'nutrient.dart';
import 'profile.dart';

class UserModel {
  String name;
  final String email;
  final String photo;
  final ProfileModel profile;
  final List<FoodModel> approvedFoods;
  final List<FoodModel> rejectedFoods;
  final List<NutrientModel> recommendedNutrients;

  UserModel({
    required this.name,
    required this.email,
    required this.photo,
    required this.profile,
    required this.approvedFoods,
    required this.rejectedFoods,
    required this.recommendedNutrients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'photo': photo,
      'profile': profile.toJson(),
      'approvedFoods':
          approvedFoods.map((approvedFood) => approvedFood.toJson()).toList(),
      'rejectedFoods':
          rejectedFoods.map((rejectedFood) => rejectedFood.toJson()).toList(),
      'recommendedNutrients': recommendedNutrients
          .map((recommendedNutrient) => recommendedNutrient.toJson())
          .toList(),
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        email = snapshot['email'],
        photo = snapshot['photo'],
        profile = ProfileModel.fromMap(snapshot['profile']),
        approvedFoods = snapshot['approvedFoods']
            .map<FoodModel>(
                (approvedFood) => FoodModel.fromDocumentSnapshot(approvedFood))
            .toList(),
        rejectedFoods = snapshot['rejectedFoods']
            .map<FoodModel>(
                (rejectedFood) => FoodModel.fromDocumentSnapshot(rejectedFood))
            .toList(),
        recommendedNutrients = snapshot['recommendedNutrients']
            .map<NutrientModel>((recommendedNutrient) =>
                NutrientModel.fromMap(recommendedNutrient))
            .toList();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user.dart';

class DatabaseService {
  final database = FirebaseFirestore.instance;

  Future<void> updateUser(UserModel user) async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final userReference = database.collection("users").doc(userAuthentication?.uid);

    await userReference.set(user.toJson(), SetOptions(merge: true));
  }

  Future<UserModel> createUser() async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final user = UserModel(
      email: userAuthentication?.email ?? '',
      name: userAuthentication?.displayName,
      photo: userAuthentication?.photoURL,
      birthday: DateTime.now().subtract(const Duration(days: 7305)),
      sex: 'xy',
      heightInches: 67,
      weightPounds: 150,
      exerciseFrequency: 'moderate',
      goal: 'maintainWeight',
    );

    await updateUser(user);

    return user;
  }

  Future<UserModel> getUser() async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final userReference = database.collection("users").doc(userAuthentication?.uid);
    final userSnapshot = await userReference.get();

    if (userSnapshot.exists) {
      return UserModel.fromDocumentSnapshot(userSnapshot);
    } else {
      return await createUser();
    }
  }
}
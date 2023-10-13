import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user.dart';

class DatabaseService {
  final database = FirebaseFirestore.instance;

  Future<User> createUser(firebase_auth.User userAuthentication) async {
    final userReference = database.collection("users").doc(userAuthentication?.uid);
    final user = User(
      name: userAuthentication.displayName ?? '',
      email: userAuthentication.email ?? '',
      photo: userAuthentication.photoURL ?? '',
    );

    await userReference.set(user.toJson(), SetOptions(merge: true));

    return user;
  }

  Future<User> getUser() async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final userReference = database.collection("users").doc(userAuthentication?.uid);
    final userSnapshot = await userReference.get();

    if (userSnapshot.exists) {
      return User.fromDocumentSnapshot(userSnapshot);
    } else {
      return await createUser(userAuthentication!);
    }
  }
}
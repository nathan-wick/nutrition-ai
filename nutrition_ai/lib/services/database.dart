import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user.dart';

class DatabaseService {
  final database = FirebaseFirestore.instance;

  Future<void> updateUser(User user) async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final userReference = database.collection("users").doc(userAuthentication?.uid);

    await userReference.set(user.toJson(), SetOptions(merge: true));
  }

  Future<User> createUser() async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final user = User(
      name: userAuthentication?.displayName ?? '',
      email: userAuthentication?.email ?? '',
      photo: userAuthentication?.photoURL ?? '',
    );

    await updateUser(user);

    return user;
  }

  Future<User> getUser() async {
    final userAuthentication = firebase_auth.FirebaseAuth.instance.currentUser;
    final userReference = database.collection("users").doc(userAuthentication?.uid);
    final userSnapshot = await userReference.get();

    if (userSnapshot.exists) {
      return User.fromDocumentSnapshot(userSnapshot);
    } else {
      return await createUser();
    }
  }
}
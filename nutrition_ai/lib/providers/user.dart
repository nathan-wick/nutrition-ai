import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/measurement.dart';
import '../models/profile.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final authentication = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  User? userAuthentication;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      userSnapshotSubscription;
  UserModel? user;

  UserProvider() {
    listenToAuthenticationChanges();
  }

  Future<UserModel?> updateUser(UserModel newUser) async {
    if (userAuthentication?.uid == null) {
      return null;
    } else {
      final userReference =
          database.collection("users").doc(userAuthentication!.uid);
      await userReference.set(newUser.toJson(), SetOptions(merge: true));
      return newUser;
    }
  }

  Future<UserModel?> createUser() async {
    final defaultUser = UserModel(
      name: userAuthentication?.displayName ?? 'Anonymous User',
      email: userAuthentication?.email ?? '',
      photo: userAuthentication?.photoURL ?? '',
      profile: ProfileModel(
        birthday: DateTime.now().subtract(const Duration(days: 7305)),
        sex: 'xy',
        height: MeasurementModel(
          amount: 67,
          unit: 'inches',
        ),
        weight: MeasurementModel(
          amount: 150,
          unit: 'pounds',
        ),
        exerciseFrequency: 'sometimes',
        goal: 'maintain',
      ),
      approvedFoods: [],
      rejectedFoods: [],
      recommendedNutrients: [],
    );
    if (userAuthentication?.uid == null) {
      return null;
    } else {
      final newUser = defaultUser;
      return updateUser(newUser);
    }
  }

  void getUser() {
    if (userAuthentication?.uid == null) {
      user = null;
    } else {
      final userReference =
          database.collection("users").doc(userAuthentication!.uid);
      userSnapshotSubscription =
          userReference.snapshots().listen((userSnapshot) async {
        if (userSnapshot.exists) {
          user = UserModel.fromDocumentSnapshot(userSnapshot);
        } else {
          user = await createUser();
        }
      });
    }
    notifyListeners();
  }

  void listenToAuthenticationChanges() {
    authentication
        .authStateChanges()
        .listen((User? newUserAuthentication) async {
      if (newUserAuthentication == null) {
        userAuthentication = null;
      } else {
        userAuthentication = newUserAuthentication;
        getUser();
      }
      notifyListeners();
    });
  }

  Future<void> signOut(BuildContext context) async {
    await userSnapshotSubscription?.cancel();
    userSnapshotSubscription = null;
    await authentication.signOut();
    Navigator.popAndPushNamed(context, '/sign-in');
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    await authentication.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userAuthentication != null) {
      Navigator.popAndPushNamed(context, '/profile');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    if (kIsWeb) {
      final authProvider = GoogleAuthProvider();
      await authentication.signInWithPopup(authProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuthentication =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication?.accessToken,
        idToken: googleAuthentication?.idToken,
      );
      await authentication.signInWithCredential(credential);
    }
    if (userAuthentication != null) {
      Navigator.popAndPushNamed(context, '/profile');
    }
  }
}

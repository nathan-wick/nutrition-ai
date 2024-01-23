import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_ai/screens/authenticated/preferences.dart';
import 'package:nutrition_ai/screens/authenticated/profile.dart';
import 'package:nutrition_ai/screens/authenticated/recommendations.dart';
import 'package:nutrition_ai/screens/authenticated/settings.dart';
import 'package:nutrition_ai/screens/sign_in.dart';
import 'package:provider/provider.dart';

import 'services/database.dart';
import 'information/firebase_options.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget checkAuthState(BuildContext context, Widget destination) {
    return context.watch<User?>() == null ? const SignInScreen() : destination;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        FutureProvider<UserModel?>(
          create: (context) => DatabaseService().getUser(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'NutriMind',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) =>
              checkAuthState(context, const RecommendationsScreen()),
          '/sign-in': (context) =>
              checkAuthState(context, const SignInScreen()),
          '/recommendations': (context) =>
              checkAuthState(context, const RecommendationsScreen()),
          '/preferences': (context) =>
              checkAuthState(context, const PreferencesScreen()),
          '/profile': (context) =>
              checkAuthState(context, const ProfileScreen()),
          '/settings': (context) =>
              checkAuthState(context, const SettingsScreen()),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

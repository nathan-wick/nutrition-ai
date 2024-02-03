import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/authenticated/preferences.dart';
import 'screens/authenticated/profile.dart';
import 'screens/authenticated/recommendations.dart';
import 'screens/authenticated/settings.dart';
import 'screens/sign_in.dart';
import 'providers/user.dart';
import 'information/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Widget checkAuthenticationState(BuildContext context, Widget destination) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.userAuthentication == null
        ? const SignInScreen()
        : destination;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        title: 'NutriMind',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) =>
              checkAuthenticationState(context, const RecommendationsScreen()),
          '/sign-in': (context) => const SignInScreen(),
          '/recommendations': (context) =>
              checkAuthenticationState(context, const RecommendationsScreen()),
          '/preferences': (context) =>
              checkAuthenticationState(context, const PreferencesScreen()),
          '/profile': (context) =>
              checkAuthenticationState(context, const ProfileScreen()),
          '/settings': (context) =>
              checkAuthenticationState(context, const SettingsScreen()),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

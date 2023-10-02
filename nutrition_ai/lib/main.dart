import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'contexts/authentication.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition AI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Authentication(),
      debugShowCheckedModeBanner: false,
    );
  }
}
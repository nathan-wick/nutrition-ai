import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'information/firebase_options.dart';
import 'widgets/navigation.dart';

void main() async {
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
        primarySwatch: Colors.blue,
      ),
      home: const Navigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
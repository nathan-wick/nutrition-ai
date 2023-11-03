import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/database.dart';
import 'contexts/authentication.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<UserModel>(
          initialData: UserModel(
            email: '',
            birthday: DateTime.now(),
            sex: '',
            heightInches: 0,
            weightPounds: 0,
            exerciseFrequency: '',
            goal: ''),
          create: (context) async => await DatabaseService().getUser(),
        ),
      ],
      child: MaterialApp(
        title: 'Nutrition AI',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Authentication(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
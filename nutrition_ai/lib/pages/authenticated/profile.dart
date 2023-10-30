import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../pages/authenticated/settings.dart';
import '../../widgets/button_input.dart';
import '../../services/database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User> user;

  void signOut() {
    firebase_auth.FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    user = DatabaseService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<User>(
            future: user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Image.network(
                      snapshot.data?.photo ?? '',
                      width: 100,
                      height: 100,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(
                          Icons.account_circle,
                          size: 100,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      snapshot.data?.name ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      snapshot.data?.email ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonInput(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Settings()),
                        );
                      },
                      icon: Icons.settings,
                      message: 'Settings',
                      theme: ButtonInputTheme.primary,
                    ),
                    const SizedBox(height: 20),
                    ButtonInput(
                      onTap: signOut,
                      icon: Icons.arrow_back,
                      message: 'Sign Out',
                      theme: ButtonInputTheme.secondary,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                signOut();
              } else {
                return const CircularProgressIndicator();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
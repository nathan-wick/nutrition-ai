import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_ai/screens/authenticated/settings.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../models/user.dart';
import '../../widgets/button_input.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 189, 226, 130),
                Color.fromARGB(255, 220, 236, 195),
                Color.fromARGB(9, 227, 222, 79),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: const Text(
                        "My Profile",
                        style: TextStyle(
                            color: Color.fromARGB(255, 28, 77, 0),
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(height: 40),
                    Center(
                    child: Image.network(
                      user.photo ?? '',
                      width: 100,
                      height: 100,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(
                          Icons.account_circle,
                          size: 100,
                        );
                      },
                    ),
                ),
                    const SizedBox(height: 10),
                    Center(
                    child:Text(
                       "Welcome ${user.name?.split(' ')[0] ?? ''}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 28, 77, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        ButtonInput(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SettingsScreen(),
                                              ),
                                            );
                                          },
                                          icon: Icons.settings,
                                          message: 'Settings',
                                          theme: ButtonInputTheme.primary,
                                        ),
                                        const SizedBox(height: 20),
                                        ButtonInput(
                                          onTap: () {
                                            FirebaseAuth.instance.signOut();
                                          },
                                          icon: Icons.arrow_back,
                                          message: 'Sign Out',
                                          theme: ButtonInputTheme.secondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

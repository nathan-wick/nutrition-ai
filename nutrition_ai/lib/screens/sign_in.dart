import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/button_input.dart';
import '../providers/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isApple = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
                Colors.green,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome to",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "NutriMind",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              // TODO Make this as tall as possible without causing scroll
              const SizedBox(height: 80),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      isApple
                          ? ButtonInput(
                              onTap: () =>
                                  userProvider.signInAnonymously(context),
                              icon: Icons.arrow_forward_ios,
                              message: 'Continue',
                              theme: ButtonInputTheme.primary,
                            )
                          : ButtonInput(
                              onTap: () =>
                                  userProvider.signInWithGoogle(context),
                              icon: Icons.account_circle,
                              message: 'Sign In With Google',
                              theme: ButtonInputTheme.primary,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      isApple
                          ? const SizedBox(
                              height: 0,
                            )
                          : ButtonInput(
                              onTap: () =>
                                  userProvider.signInAnonymously(context),
                              icon: Icons.arrow_forward_ios,
                              message: 'Skip Sign In',
                              theme: ButtonInputTheme.secondary,
                            ),
                      const SizedBox(
                        height: 20,
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

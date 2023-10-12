import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/authentication.dart';
import '../../widgets/button_input.dart';
import '../../widgets/square_tile.dart';
import '../../widgets/text_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) => Navigator.pop(context));
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text('${error.code}: ${error.message}')
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 40),
              TextInput(
                controller: emailController,
                name: 'Email',
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: passwordController,
                name: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              ButtonInput(
                onTap: signIn,
                icon: Icons.arrow_forward,
                message: 'Sign In',
                theme: ButtonInputTheme.primary,
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.4,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.4,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    onTap: () => AuthenticationService().signInWithGoogle(),
                    imagePath: 'assets/images/logos/google.png',
                  ),
                  const SizedBox(width: 20),
                  SquareTile(
                    onTap: () {},
                    imagePath: 'assets/images/logos/apple.png',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
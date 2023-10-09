import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/authentication.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import '../../widgets/square_tile.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameController = TextEditingController();
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
        email: usernameController.text,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 40),
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyButton(
                onTap: signIn,
                message: 'Sign In',
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
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  static const _placeholder = Text(
    'Account Screen Placeholder',
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _placeholder,
      ),
    );
  }
}

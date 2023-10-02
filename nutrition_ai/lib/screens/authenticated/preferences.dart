import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  static const _placeholder = Text(
    'Preferences Screen Placeholder',
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

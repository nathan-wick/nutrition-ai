import 'package:flutter/material.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  static const _placeholder = Text(
    'Recommendations Screen Placeholder',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Recommendations'),
      ),
      body: const Center(
        child: _placeholder,
      ),
    );
  }
}

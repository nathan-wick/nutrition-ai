import 'package:flutter/material.dart';

import '../../contexts/authentication.dart';
import '../../models/meal.dart' as meal_model;

class Meal extends StatelessWidget {
  final meal_model.Meal meal;

  const Meal({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Authentication()),
            );
          },
        ),
        title: Text(meal.name),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Meal Screen Placeholder'),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../models/food.dart';

class FoodScreen extends StatelessWidget {
  final FoodModel food;

  const FoodScreen({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/recommendations');
          },
        ),
        title: Text(
          food.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  food.image != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            food.image ?? '',
                            height: 300,
                            width: 500,
                          ),
                        )
                      : const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (food.ingredients != null)
                                    for (var ingredient in food.ingredients!)
                                      Text(
                                          "• ${ingredient.name} - ${ingredient.amount.amount} ${ingredient.amount.unit}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

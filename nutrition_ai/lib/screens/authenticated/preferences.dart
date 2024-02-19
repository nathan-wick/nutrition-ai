import 'package:flutter/material.dart';

import '../../models/food.dart';
import '../../widgets/main_navigation_bar.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<FoodModel> foods = [];

  int currentFoodIndex = 0;

  void nextFood() {
    if (currentFoodIndex < foods.length - 1) {
      setState(() {
        currentFoodIndex++;
      });
    } else {
      setState(() {
        currentFoodIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final food = foods[currentFoodIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Preferences'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  food.image != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            food.image ?? '',
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
                                          "• ${ingredient.name} - ${ingredient.amount}"),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      nextFood();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    nextFood();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Skip'),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      nextFood();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 1,
      ),
    );
  }
}

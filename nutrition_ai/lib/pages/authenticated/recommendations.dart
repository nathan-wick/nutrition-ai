import 'package:flutter/material.dart';

import '../../models/meal.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  late List<List<Meal>> recommendations;

  @override
  void initState() {
    super.initState();
    // TODO: Replace this example data with real data
    recommendations = [
      [
        Meal(
          name: 'Moroccan Carrot Soup',
          photo: 'https://www.themealdb.com/images/media/meals/jcr46d1614763831.jpg',
        ),
        Meal(
          name: 'Spaghetti Bolognese',
          photo: 'https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg',
        ),
        Meal(
          name: 'Chocolate Gateau',
          photo: 'https://www.themealdb.com/images/media/meals/tqtywx1468317395.jpg',
        ),
      ],
      [
        Meal(
          name: 'Moroccan Carrot Soup',
          photo: 'https://www.themealdb.com/images/media/meals/jcr46d1614763831.jpg',
        ),
        Meal(
          name: 'Spaghetti Bolognese',
          photo: 'https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg',
        ),
        Meal(
          name: 'Chocolate Gateau',
          photo: 'https://www.themealdb.com/images/media/meals/tqtywx1468317395.jpg',
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Recommendations'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
              itemCount: recommendations.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext recommendationContext, int recommendationIndex) {
                List<Meal> meals = recommendations[recommendationIndex];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Day ${recommendationIndex + 1}',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: meals.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext mealContext, int mealIndex) {
                        Meal meal = meals[mealIndex];
                        return Card(
                          child: ListTile(
                            title: Text(
                              meal.name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // TODO: Navigate to a meal page.
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}

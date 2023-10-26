import 'package:flutter/material.dart';

import '../../models/meal.dart' as meal_model;
import 'meal.dart' as meal_screen;

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  late List<List<meal_model.Meal>> recommendations;

  @override
  void initState() {
    super.initState();
    // TODO: Replace this example data with real data
    recommendations = [
      [
        meal_model.Meal(
          name: 'Teriyaki Chicken Casserole',
          photo: 'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
        ),
        meal_model.Meal(
          name: 'Spaghetti Bolognese',
          photo: 'https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg',
        ),
        meal_model.Meal(
          name: 'Chocolate Gateau',
          photo: 'https://www.themealdb.com/images/media/meals/tqtywx1468317395.jpg',
        ),
      ],
      [
        meal_model.Meal(
          name: 'Pad See Ew',
          photo: 'https://www.themealdb.com/images/media/meals/uuuspp1468263334.jpg',
        ),
        meal_model.Meal(
          name: 'Spicy Arrabiata Penne',
          photo: 'https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg',
        ),
        meal_model.Meal(
          name: 'Honey Teriyaki Salmon',
          photo: 'https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg',
        ),
      ],
      [
        meal_model.Meal(
          name: 'Mediterranean Pasta Salad',
          photo: 'https://www.themealdb.com/images/media/meals/wvqpwt1468339226.jpg',
        ),
        meal_model.Meal(
          name: 'Smoky Lentil Chili with Squash',
          photo: 'https://www.themealdb.com/images/media/meals/uwxqwy1483389553.jpg',
        ),
        meal_model.Meal(
          name: 'Rocky Road Fudge',
          photo: 'https://www.themealdb.com/images/media/meals/vtxyxv1483567157.jpg',
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                title: const Text('Recommendations'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      // TODO: Refresh meal recommendations
                    },
                  ),
                ],
              ),
            ];
          },
          body: ListView.builder(
            itemCount: recommendations.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext recommendationContext, int recommendationIndex) {
              List<meal_model.Meal> meals = recommendations[recommendationIndex];
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
                      meal_model.Meal meal = meals[mealIndex];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(meal.photo),
                          ),
                          title: Text(
                            meal.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                meal_screen.Meal(
                                  meal: meal,
                                ),
                              ),
                            );
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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../models/food.dart';
import '../../widgets/main_navigation_bar.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  List<FoodModel> recommendedDailyFoods = [];
  bool isGettingRecommendedDailyFoods = false;

  @override
  void initState() {
    super.initState();
    getRecommendedDailyFoods();
  }

  Future<void> getRecommendedDailyFoods() async {
    if (isGettingRecommendedDailyFoods) {
      return;
    }
    setState(() {
      isGettingRecommendedDailyFoods = true;
    });
    List<FoodModel> newRecommendedDailyFoods = [];
    try {
      final results = await FirebaseFunctions.instance
          .httpsCallable('getRecommendedDailyFoods')
          .call();
      if (results.data is List) {
        for (final foodData in results.data as List) {
          newRecommendedDailyFoods
              .add(FoodModel.fromMap(foodData as Map<String, dynamic>));
        }
      }
    } on FirebaseFunctionsException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    setState(() {
      recommendedDailyFoods = newRecommendedDailyFoods;
      isGettingRecommendedDailyFoods = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.white],
          ),
        ),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  title: const Text('Recommendations',
                      style: TextStyle(color: Colors.white)),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      color: Colors.white,
                      onPressed: () {
                        getRecommendedDailyFoods();
                      },
                    ),
                  ],
                ),
              ];
            },
            body: Card(
              color: const Color(0xFFF3FCF3),
              margin: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext recommendationContext,
                    int recommendationIndex) {
                  List<FoodModel> foods = recommendedDailyFoods;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Today\'s Menu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        itemCount: foods.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext foodContext, int foodIndex) {
                          FoodModel food = foods[foodIndex];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // TODO Use fetchFoodImage()
                                          Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/nathan-wick-nutrition-ai.appspot.com/o/category_images%2F6411.jpeg?alt=media&token=8c1f3f6b-5547-4122-b298-54a31630ce5d'),
                                          Text(
                                            food.name,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            children: [
                                              Card(
                                                margin: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                elevation: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Ingredients",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: food
                                                                .ingredients
                                                                ?.map((ingredient) =>
                                                                    Text(
                                                                        "• ${ingredient.name} - ${ingredient.amount.amount.toStringAsFixed(0)}${ingredient.amount.unit}"))
                                                                .toList() ??
                                                            [
                                                              const Text(
                                                                  "No ingredients available")
                                                            ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 100,
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/nathan-wick-nutrition-ai.appspot.com/o/category_images%2F6411.jpeg?alt=media&token=8c1f3f6b-5547-4122-b298-54a31630ce5d'), // Replace with actual image URL
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              food.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "• ${food.description}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 0,
      ),
    );
  }
}

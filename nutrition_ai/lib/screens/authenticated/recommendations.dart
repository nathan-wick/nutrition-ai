import 'package:flutter/material.dart';

import '../../models/food.dart';
import '../../widgets/main_navigation_bar.dart';
import 'food.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  late List<List<FoodModel>> recommendations;

  @override
  void initState() {
    super.initState();
    recommendations = [];
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
                      // TODO: Refresh recommendations
                    },
                  ),
                ],
              ),
            ];
          },
          body: ListView.builder(
            itemCount: recommendations.length,
            shrinkWrap: true,
            itemBuilder:
                (BuildContext recommendationContext, int recommendationIndex) {
              List<FoodModel> foods = recommendations[recommendationIndex];
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
                    itemCount: foods.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext foodContext, int foodIndex) {
                      FoodModel food = foods[foodIndex];
                      return Card(
                        child: ListTile(
                          // TODO Add image
                          title: Text(
                            food.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodScreen(
                                  food: food,
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
            },
          ),
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 0,
      ),
    );
  }
}

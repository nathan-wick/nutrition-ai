import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../utilities/to_number_string.dart';
import '../../utilities/fetch_food_image.dart';
import '../../models/food.dart';
import '../../widgets/main_navigation_bar.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  List<FoodModel> recommendedDailyFoods = [];
  List<Widget> recommendedDailyFoodWidgets = [];
  bool isGettingRecommendedDailyFoods = false;

  @override
  void initState() {
    super.initState();
    getRecommendedDailyFoods();
  }

  Widget getRecommendedDailyFoodWidget(FoodModel recommendedDailyFood) {
    // TODO Add details popup on tap
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(recommendedDailyFood.image ?? ''),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendedDailyFood.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    ListView.builder(
                      itemCount: recommendedDailyFood.ingredients?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (
                        BuildContext ingredientContext,
                        int ingredientIndex,
                      ) {
                        final ingredient =
                            recommendedDailyFood.ingredients![ingredientIndex];
                        final ingredientString =
                            '• ${ingredient.name} (${toNumberString(ingredient.amount.amount)} ${ingredient.amount.unit})';
                        return Text(
                          ingredientString,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> getRecommendedDailyFoods() async {
    if (isGettingRecommendedDailyFoods) {
      return;
    }
    setState(() {
      isGettingRecommendedDailyFoods = true;
    });
    List<FoodModel> newRecommendedDailyFoods = [];
    List<Widget> newRecommendedDailyFoodWidgets = [];
    try {
      final results = await FirebaseFunctions.instance
          .httpsCallable('getRecommendedDailyFoods')
          .call();
      final recommendedFoodsData = results.data as List;
      newRecommendedDailyFoods = recommendedFoodsData
          .map((data) => FoodModel.fromMap(jsonDecode(jsonEncode(data))))
          .toList();
      for (final newRecommendedDailyFood in newRecommendedDailyFoods) {
        newRecommendedDailyFood.image = await fetchFoodImage(
            newRecommendedDailyFood.category.code.toStringAsFixed(0));
      }
      newRecommendedDailyFoodWidgets = newRecommendedDailyFoods
          .map((newRecommendedDailyFood) =>
              getRecommendedDailyFoodWidget(newRecommendedDailyFood))
          .toList();
    } on FirebaseFunctionsException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    setState(() {
      recommendedDailyFoods = newRecommendedDailyFoods;
      recommendedDailyFoodWidgets = newRecommendedDailyFoodWidgets;
      isGettingRecommendedDailyFoods = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: () {
              getRecommendedDailyFoods();
            },
          )
        ],
        title: const Text(
          'Today\'s Meal Plan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Theme.of(context).primaryColor],
            ),
          ),
          child: isGettingRecommendedDailyFoods
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Generating your recommended meal plan...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : recommendedDailyFoodWidgets.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Failed to generate your recommended meal plan. Please try again.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: recommendedDailyFoodWidgets,
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

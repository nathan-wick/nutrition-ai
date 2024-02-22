import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_ai/utilities/fetch_food_image.dart';
import 'package:provider/provider.dart';

import '../../models/food.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
import '../../widgets/button_input.dart';
import '../../widgets/main_navigation_bar.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<FoodModel> foods = [];
  DocumentSnapshot? lastVisibleFoodSnapshot;
  bool fetchingFoods = false;
  bool moreFoodsExist = true;
  int foodsPerFetch = 7;
  int currentFoodIndex = 0;
  bool updatingUser = false;
  String foodImage =
      "https://firebasestorage.googleapis.com/v0/b/nathan-wick-nutrition-ai.appspot.com/o/category_images%2Ftest.jpeg?alt=media&token=9564fe97-a118-41d8-bb01-bdbaff95e18e";

  Future<void> fetchFoods() async {
    if (!fetchingFoods && moreFoodsExist) {
      fetchingFoods = true;
      final List<FoodModel> newFoods = [];
      final foodsReference = FirebaseFirestore.instance
          .collection("usda_foods")
          .orderBy(FieldPath.documentId)
          .limit(foodsPerFetch);
      QuerySnapshot foodsSnapshot;
      if (lastVisibleFoodSnapshot == null) {
        foodsSnapshot = await foodsReference.get();
      } else {
        foodsSnapshot = await foodsReference
            .startAfterDocument(lastVisibleFoodSnapshot!)
            .get();
      }
      if (foodsSnapshot.docs.length < foodsPerFetch) {
        moreFoodsExist = false;
      }
      for (QueryDocumentSnapshot<Object?> foodDocument in foodsSnapshot.docs) {
        newFoods.add(FoodModel.fromDocumentSnapshot(foodDocument));
      }
      setState(() {
        foods.addAll(newFoods);
      });
      // TODO Does this need to be inside a setState?
      lastVisibleFoodSnapshot =
          foodsSnapshot.docs.isNotEmpty ? foodsSnapshot.docs.last : null;
      fetchingFoods = false;
    }
  }

  Future<void> nextFood() async {
    if (!fetchingFoods && moreFoodsExist) {
      if (currentFoodIndex < foods.length - 1) {
        await fetchFoods();
      }
      final newFoodImage = await fetchFoodImage(
          foods[currentFoodIndex].category.code.toStringAsFixed(0));
      setState(() {
        currentFoodIndex++;
        foodImage = newFoodImage;
      });
    }
  }

  Future<void> approveFood(UserProvider userProvider, UserModel? user) async {
    if (!updatingUser && user != null) {
      updatingUser = true;
      FoodModel foodToApprove = foods[currentFoodIndex];
      bool userAlreadyApproved = user.approvedFoods
          .any((approvedFood) => approvedFood.code == foodToApprove.code);
      await nextFood(); // TODO This may need moved to after we update user
      if (!userAlreadyApproved) {
        user.approvedFoods.add(foodToApprove);
        await userProvider.updateUser(user);
      }
      updatingUser = false;
    }
  }

  Future<void> rejectFood(UserProvider userProvider, UserModel? user) async {
    if (!updatingUser && user != null) {
      updatingUser = true;
      FoodModel foodToReject = foods[currentFoodIndex];
      bool userAlreadyRejected = user.rejectedFoods
          .any((approvedFood) => approvedFood.code == foodToReject.code);
      await nextFood(); // TODO This may need moved to after we update user
      if (!userAlreadyRejected) {
        user.approvedFoods.add(foodToReject);
        await userProvider.updateUser(user);
      }
      updatingUser = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.user;
    FoodModel? food;
    if (foods.isNotEmpty) {
      food = foods[currentFoodIndex];
    }
    return Scaffold(
      body: food != null
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            foodImage,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Card(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (food.ingredients != null)
                                          for (var ingredient
                                              in food.ingredients!)
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: ButtonInput(
                          onTap: () {
                            approveFood(userProvider, user);
                          },
                          icon: Icons.close,
                          message: 'Reject',
                          theme: ButtonInputTheme.danger,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ButtonInput(
                        onTap: () {
                          nextFood();
                        },
                        icon: Icons.arrow_forward,
                        message: 'Skip',
                        theme: ButtonInputTheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ButtonInput(
                          onTap: () {
                            rejectFood(userProvider, user);
                          },
                          icon: Icons.check,
                          message: 'Approve',
                          theme: ButtonInputTheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You've run out of food! Please come again later."),
                ],
              ),
            ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 1,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_ai/utilities/fetch_food_image.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
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
  String? foodImage;

  Future<void> fetchFoods(UserModel? user) async {
    if (!fetchingFoods && moreFoodsExist && user != null) {
      fetchingFoods = true;
      final List<FoodModel> newFoods = [];
      final List<String> viewedCodes = [];
      viewedCodes.addAll(user.approvedFoods.map((food) => food.code).toList());
      viewedCodes.addAll(user.rejectedFoods.map((food) => food.code).toList());
      final foodsReference = viewedCodes.isEmpty
          ? FirebaseFirestore.instance
              .collection("usda_foods")
              .orderBy("code")
              .limit(foodsPerFetch)
          : FirebaseFirestore.instance
              .collection("usda_foods")
              .where("code", whereNotIn: viewedCodes)
              .orderBy("code")
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
      lastVisibleFoodSnapshot =
          foodsSnapshot.docs.isNotEmpty ? foodsSnapshot.docs.last : null;
      fetchingFoods = false;
      setFoodImage();
    }
  }

  Future<void> nextFood(UserModel? user) async {
    if (!fetchingFoods && moreFoodsExist) {
      if (currentFoodIndex == foods.length - 1) {
        await fetchFoods(user);
      }
      final nextFoodIndex = currentFoodIndex + 1;
      setState(() {
        currentFoodIndex = nextFoodIndex;
      });
      setFoodImage();
    }
  }

  Future<void> approveFood(UserProvider userProvider, UserModel? user) async {
    if (!updatingUser && user != null) {
      updatingUser = true;
      FoodModel foodToApprove = foods[currentFoodIndex];
      bool userAlreadyApproved = user.approvedFoods
          .any((approvedFood) => approvedFood.code == foodToApprove.code);
      await nextFood(user);
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
      await nextFood(user);
      if (!userAlreadyRejected) {
        user.rejectedFoods.add(foodToReject);
        await userProvider.updateUser(user);
      }
      updatingUser = false;
    }
  }

  Future<void> setFoodImage() async {
    final String? newFoodImage = await fetchFoodImage(
        foods[currentFoodIndex].category.code.toStringAsFixed(0));
    setState(() {
      foodImage = newFoodImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.user;
    final FoodModel? food = foods.isNotEmpty ? foods[currentFoodIndex] : null;
    if (foods.isEmpty) {
      fetchFoods(user);
    }
    return Scaffold(
      body: food != null
          ? Column(
              children: [
                Expanded(
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 100.0),
                        foodImage == null
                            ? const SizedBox(height: 20)
                            :Align(
                              alignment: Alignment.center,
                            child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      const Color.fromARGB(255, 181, 227, 182),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    foodImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              ) ,
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              2, // Half of the screen height
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 208, 232,
                                        182), // Set the color here
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ), // Optional: Add rounded corners
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 20.0), // Add padding horizontally
                                        child: Text(
                                          food.name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Ingredients",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (food.ingredients !=
                                                          null)
                                                        for (var ingredient
                                                            in food
                                                                .ingredients!)
                                                          Text(
                                                              "• ${ingredient.name} - ${ingredient.amount.amount.toStringAsFixed(0)}${ingredient.amount.unit}"),
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
                        ),
                      ],
                      
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 208, 232,
                      182), // Set the color here, // Set the background color here
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonInput(
                            onTap: () {
                              rejectFood(userProvider, user);
                            },
                            icon: Icons.thumb_down,
                            message: 'Reject',
                            theme: ButtonInputTheme.danger,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ButtonInput(
                          onTap: () {
                            nextFood(user);
                          },
                          icon: Icons.arrow_forward_ios,
                          message: 'Skip',
                          theme: ButtonInputTheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonInput(
                            onTap: () {
                              approveFood(userProvider, user);
                            },
                            icon: Icons.thumb_up,
                            message: 'Approve',
                            theme: ButtonInputTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
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

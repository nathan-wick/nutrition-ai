import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/fetch_food_image.dart';
import '../../models/food.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
import '../../utilities/to_number_string.dart';
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
      final foodsReference = FirebaseFirestore.instance
          .collection("usda_foods")
          .orderBy("code")
          .limit(foodsPerFetch);
      QuerySnapshot foodsSnapshot;
      if (lastVisibleFoodSnapshot == null) {
        final List<String> viewedCodes = [];
        viewedCodes
            .addAll(user.approvedFoods.map((food) => food.code).toList());
        viewedCodes
            .addAll(user.rejectedFoods.map((food) => food.code).toList());
        if (viewedCodes.isEmpty) {
          foodsSnapshot = await foodsReference.get();
        } else {
          viewedCodes.sort();
          lastVisibleFoodSnapshot = await FirebaseFirestore.instance
              .collection("usda_foods")
              .doc(viewedCodes.last)
              .get();
          if (lastVisibleFoodSnapshot == null) {
            foodsSnapshot = await foodsReference.get();
          } else {
            foodsSnapshot = await foodsReference
                .startAfterDocument(lastVisibleFoodSnapshot!)
                .get();
          }
        }
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
    final String newFoodImage = await fetchFoodImage(
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Preferences',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            decoration: foodImage == null
                ? BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blueGrey, Theme.of(context).primaryColor],
                    ),
                  )
                : BoxDecoration(
                    color: Colors.blueGrey,
                    image: DecorationImage(
                      image: NetworkImage(foodImage ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
            child: fetchingFoods && foods.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Loading foods...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : food == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "You've run out of food! Please come again later.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 400,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          food.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Ingredients",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            ListView.builder(
                                              itemCount:
                                                  food.ingredients?.length ?? 0,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (
                                                BuildContext ingredientContext,
                                                int ingredientIndex,
                                              ) {
                                                final ingredient =
                                                    food.ingredients![
                                                        ingredientIndex];
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
                                      const SizedBox(
                                        height: 400,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 8, right: 8),
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
      ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 1,
      ),
    );
  }
}

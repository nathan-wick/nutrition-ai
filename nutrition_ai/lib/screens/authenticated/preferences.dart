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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 100.0),
                      foodImage == null
                          ? SizedBox(height: 100)
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  foodImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      SingleChildScrollView(
                        // flex:1,
  child: Container(
    color: Color.fromARGB(255, 195, 126, 126),
    child: Column(
      mainAxisSize: MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
      children: [
        Flexible( // Wrap your RenderFlex with Flexible
          fit: FlexFit.loose, // Set FlexFit.loose for flexible behavior
          child: Card(
            
            margin: const EdgeInsets.only(left: 50, right: 50, top: 80,bottom: 80),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                 const Text(
                    "Ingredients",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ), 
                  const SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(food.ingredients  != null)
                        for (var ingredient in food.ingredients!)
                          Text(
                            "• ${ingredient.name} - ${ingredient.amount.amount.toStringAsFixed(0)}${ingredient.amount.unit}"
                          ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),
                ClipRect(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                          SizedBox(width: 8),
                          ButtonInput(
                            onTap: () {
                              nextFood(user);
                            },
                            icon: Icons.arrow_forward_ios,
                            message: 'Skip',
                            theme: ButtonInputTheme.secondary,
                          ),
                          SizedBox(width: 8),
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
                  ),
                ),
              ),
            ],
          )
        : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You've run out of food! Please come again later."),
                  SizedBox(
                      height: 20), // Add spacing between ingredients and button
                ],
              ),
            ),
                  bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 1,),
  );
}
}


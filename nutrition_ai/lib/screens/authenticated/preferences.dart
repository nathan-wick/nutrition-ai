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
      ? Container(
          color: const Color.fromARGB(255, 176, 227, 178),
          height: 400,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: const SizedBox(height: 20),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Color.fromARGB(255, 243, 252, 243),
                      ),
                    ),
                  ),
                ],
              ),
              if (foodImage != null) // Check if foodImage is not null
                Positioned(
                  top: 50, // Adjust top position as needed
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 93, 92, 92)
                                .withOpacity(0.3),
                            offset: Offset(-1, 10),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          foodImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 350, // Adjust top position as needed
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
  }}
import 'package:flutter/material.dart';

import '../../models/ingredient.dart';
import '../../models/meal.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  final List<Meal> meals = [
    Meal(
      name: "Teriyaki Chicken Casserole",
      photo: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
      instruction: "Preheat oven to 350\u00b0 F. Spray a 9x13-inch baking pan with non-stick spray. Combine soy sauce, cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling. Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat. Place the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks. *Meanwhile, steam or cook the vegetables according to package directions. Add the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
      ingredients: [
        Ingredient(name: "soy sauce", amount: "3/4 cup"),
        Ingredient(name: "water", amount: "1/2 cup"),
        Ingredient(name: "brown sugar", amount: "1/4 cup"),
        Ingredient(name: "ground ginger", amount: "1/2 teaspoon"),
        Ingredient(name: "minced garlic", amount: "1/2 teaspoon"),
        Ingredient(name: "cornstarch", amount: "4 Tablespoons"),
        Ingredient(name: "chicken breasts", amount: "2"),
        Ingredient(name: "stir-fry vegetables", amount: "1 (12 oz.)"),
      ]),
    Meal(
      name: "Spaghetti Bolognese",
      photo: "https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg",
      instruction: "Put the onion and oil in a large pan and fry over a fairly high heat for 3-4 mins. Add the garlic and mince and fry until they both brown. Add the mushrooms and herbs, and cook for another couple of mins. Stir in the tomatoes, beef stock, tomato ketchup or pur e, Worcestershire sauce and seasoning. Bring to the boil, then reduce the heat, cover and simmer, stirring occasionally, for 30 mins. Meanwhile, cook the spaghetti in a large pan of boiling, salted water, according to packet instructions. Drain well, run hot water through it, put it back in the pan and add a dash of olive oil, if you like, then stir in the meat sauce. Serve in hot bowls and hand round Parmesan cheese, for sprinkling on top.",
      ingredients: [
        Ingredient(name: "onions", amount: "2"),
        Ingredient(name: "olive oil", amount: "1tbsp"),
        Ingredient(name: "garlic", amount: "1 clove"),
        Ingredient(name: "lean minced beef", amount: "500g"),
        Ingredient(name: "mushrooms", amount: "90g"),
        Ingredient(name: "dried oregano", amount: "1tsp"),
        Ingredient(name: "tomatoes", amount: "400g can"),
        Ingredient(name: "hot beef stock", amount: "300ml"),
      ]),
    Meal(
      name: "Chocolate Gateau",
      photo: "https://www.themealdb.com/images/media/meals/tqtywx1468317395.jpg",
      instruction: "Preheat the oven to 180 C/350 F/Gas Mark 4. Grease and line the base of an 8 in round spring form cake tin with baking parchment Break the chocolate into a heatproof bowl and place over a saucepan of gently simmering water and stir until it melts. (or melt in the microwave for 2-3 mins stirring occasionally) Place the butter and sugar in a mixing bowl and cream together with a wooden spoon until light and fluffy. Gradually beat in the eggs, adding a little flour if the mixture begins to curdle. Fold in the remaining flour with the cooled, melted chocolate and milk. Mix until smooth. Spread the mixture into the cake tin and bake for 50-55 mins or until firm in the centre and a skewer comes out cleanly. Cool for 10 minutes, then turn out and cool completely.",
      ingredients: [
        Ingredient(name: "Plain chocolate", amount: "250g"),
        Ingredient(name: "Butter", amount: "175g"),
        Ingredient(name: "Milk", amount: "2 tablespoons"),
        Ingredient(name: "Eggs", amount: "5"),
        Ingredient(name: "Granulated Sugar", amount: "175g"),
        Ingredient(name: "Flour", amount: "125g"),
      ]),
  ];

  int currentMealIndex = 0;

  void nextMeal() {
    if (currentMealIndex < meals.length - 1) {
      setState(() {
        currentMealIndex++;
      });
    } else {
      setState(() {
        currentMealIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meal = meals[currentMealIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Preferences'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      meal.photo,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(left: 10, right: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (meal.ingredients != null)
                                    for (var ingredient in meal.ingredients!)
                                      Text("• ${ingredient.name} - ${ingredient.amount}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Card(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Instructions:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(meal.instruction ?? "No instructions found"),
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
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      nextMeal();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    nextMeal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey
                  ),
                  child: const Text('Skip'),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      nextMeal();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                    ),
                    child: const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




















































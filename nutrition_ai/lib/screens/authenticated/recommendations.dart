import 'package:flutter/material.dart';
import 'package:nutrition_ai/models/ingredient.dart';

import '../../models/meal.dart';
import '../../widgets/main_navigation_bar.dart';
import 'meal.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  late List<List<MealModel>> recommendations;

  @override
  void initState() {
    super.initState();
    // TODO: Replace this example data with real data
    recommendations = [
      [
        MealModel(
            name: "Teriyaki Chicken Casserole",
            photo:
                "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
            instruction:
                "Preheat oven to 350\u00b0 F. Spray a 9x13-inch baking pan with non-stick spray. Combine soy sauce, cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling. Meanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat. Place the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks. *Meanwhile, steam or cook the vegetables according to package directions. Add the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
            ingredients: [
              IngredientModel(name: "soy sauce", amount: "3/4 cup"),
              IngredientModel(name: "water", amount: "1/2 cup"),
              IngredientModel(name: "brown sugar", amount: "1/4 cup"),
              IngredientModel(name: "ground ginger", amount: "1/2 teaspoon"),
              IngredientModel(name: "minced garlic", amount: "1/2 teaspoon"),
              IngredientModel(name: "cornstarch", amount: "4 Tablespoons"),
              IngredientModel(name: "chicken breasts", amount: "2"),
              IngredientModel(
                  name: "stir-fry vegetables", amount: "1 (12 oz.)"),
            ]),
        MealModel(
            name: "Spaghetti Bolognese",
            photo:
                "https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg",
            instruction:
                "Put the onion and oil in a large pan and fry over a fairly high heat for 3-4 mins. Add the garlic and mince and fry until they both brown. Add the mushrooms and herbs, and cook for another couple of mins. Stir in the tomatoes, beef stock, tomato ketchup or pur e, Worcestershire sauce and seasoning. Bring to the boil, then reduce the heat, cover and simmer, stirring occasionally, for 30 mins. Meanwhile, cook the spaghetti in a large pan of boiling, salted water, according to packet instructions. Drain well, run hot water through it, put it back in the pan and add a dash of olive oil, if you like, then stir in the meat sauce. Serve in hot bowls and hand round Parmesan cheese, for sprinkling on top.",
            ingredients: [
              IngredientModel(name: "onions", amount: "2"),
              IngredientModel(name: "olive oil", amount: "1tbsp"),
              IngredientModel(name: "garlic", amount: "1 clove"),
              IngredientModel(name: "lean minced beef", amount: "500g"),
              IngredientModel(name: "mushrooms", amount: "90g"),
              IngredientModel(name: "dried oregano", amount: "1tsp"),
              IngredientModel(name: "tomatoes", amount: "400g can"),
              IngredientModel(name: "hot beef stock", amount: "300ml"),
            ]),
        MealModel(
            name: "Chocolate Gateau",
            photo:
                "https://www.themealdb.com/images/media/meals/tqtywx1468317395.jpg",
            instruction:
                "Preheat the oven to 180 C/350 F/Gas Mark 4. Grease and line the base of an 8 in round spring form cake tin with baking parchment Break the chocolate into a heatproof bowl and place over a saucepan of gently simmering water and stir until it melts. (or melt in the microwave for 2-3 mins stirring occasionally) Place the butter and sugar in a mixing bowl and cream together with a wooden spoon until light and fluffy. Gradually beat in the eggs, adding a little flour if the mixture begins to curdle. Fold in the remaining flour with the cooled, melted chocolate and milk. Mix until smooth. Spread the mixture into the cake tin and bake for 50-55 mins or until firm in the centre and a skewer comes out cleanly. Cool for 10 minutes, then turn out and cool completely.",
            ingredients: [
              IngredientModel(name: "Plain chocolate", amount: "250g"),
              IngredientModel(name: "Butter", amount: "175g"),
              IngredientModel(name: "Milk", amount: "2 tablespoons"),
              IngredientModel(name: "Eggs", amount: "5"),
              IngredientModel(name: "Granulated Sugar", amount: "175g"),
              IngredientModel(name: "Flour", amount: "125g"),
            ]),
      ],
      [
        MealModel(
            name: "Pad See Ew",
            photo:
                "https://www.themealdb.com/images/media/meals/uuuspp1468263334.jpg",
            instruction:
                "Mix Sauce in small bowl. Mince garlic into wok with oil. Place over high heat, when hot, add chicken and Chinese broccoli stems, cook until chicken is light golden. Push to the side of the wok, crack egg in and scramble. Don't worry if it sticks to the bottom of the wok - it will char and which adds authentic flavour. Add noodles, Chinese broccoli leaves and sauce. Gently mix together until the noodles are stained dark and leaves are wilted. Serve immediately!",
            ingredients: [
              IngredientModel(name: "rice stick noodles", amount: "6oz/180g"),
              IngredientModel(name: "dark soy sauce", amount: "2 tbsp"),
              IngredientModel(name: "oyster sauce", amount: "2 tbsp"),
              IngredientModel(name: "soy sauce", amount: "2 tsp"),
              IngredientModel(name: "white vinegar", amount: "2 tsp"),
              IngredientModel(name: "sugar", amount: "2 tsp"),
              IngredientModel(name: "water", amount: "2 tbsp"),
              IngredientModel(name: "peanut oil", amount: "2 tbsp"),
            ]),
        MealModel(
            name: "Spicy Arrabiata Penne",
            photo:
                "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
            instruction:
                "Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes. In a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil. Drain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.",
            ingredients: [
              IngredientModel(name: "penne rigate", amount: "1 pound"),
              IngredientModel(name: "olive oil", amount: "1/4 cup"),
              IngredientModel(name: "garlic", amount: "3 cloves"),
              IngredientModel(name: "chopped tomatoes", amount: "1 tin "),
              IngredientModel(name: "red chile flakes", amount: "1/2 teaspoon"),
              IngredientModel(
                  name: "italian seasoning", amount: "1/2 teaspoon"),
              IngredientModel(name: "basil", amount: "6 leaves"),
              IngredientModel(name: "Parmigiano-Reggiano", amount: "spinkling"),
            ]),
        MealModel(
            name: "Honey Teriyaki Salmon",
            photo:
                "https://www.themealdb.com/images/media/meals/xxyupu1468262513.jpg",
            instruction:
                "Mix all the ingredients in the Honey Teriyaki Glaze together. Whisk to blend well. Combine the salmon and the Glaze together. Heat up a skillet on medium-low heat. Add the oil, Pan-fry the salmon on both sides until it completely cooked inside and the glaze thickens. Garnish with sesame and serve immediately.",
            ingredients: [
              IngredientModel(name: "Salmon", amount: "1 lb"),
              IngredientModel(name: "Olive oil", amount: "1 tablespoon"),
              IngredientModel(name: "Soy Sauce", amount: "2 tablespoons"),
              IngredientModel(name: "Sake", amount: "2 tablespoons"),
              IngredientModel(name: "Sesame Seed", amount: "4 tablespoons"),
            ]),
      ],
      [
        MealModel(
            name: "Mediterranean Pasta Salad",
            photo:
                "https://www.themealdb.com/images/media/meals/wvqpwt1468339226.jpg",
            instruction:
                "Bring a large saucepan of salted water to the boil Add the pasta, stir once and cook for about 10 minutes or as directed on the packet. Meanwhile, wash the tomatoes and cut into quarters. Slice the olives. Wash the basil. Put the tomatoes into a salad bowl and tear the basil leaves over them. Add a tablespoon of olive oil and mix. When the pasta is ready, drain into a colander and run cold water over it to cool it quickly. Toss the pasta into the salad bowl with the tomatoes and basil. Add the sliced olives, drained mozzarella balls, and chunks of tuna. Mix well and let the salad rest for at least half an hour to allow the flavours to mingle. Sprinkle the pasta with a generous grind of black pepper and drizzle with the remaining olive oil just before serving.",
            ingredients: [
              IngredientModel(name: "mozzarella balls", amount: "200 g"),
              IngredientModel(name: "baby plum tomatoes", amount: "250 g"),
              IngredientModel(name: "fresh basil", amount: "1 bunch"),
              IngredientModel(name: "farfalle", amount: "350 g"),
              IngredientModel(
                  name: "extra virgin olive oil", amount: "3 tablespoons"),
              IngredientModel(name: "Green Olives", amount: "40 g"),
              IngredientModel(name: "tuna", amount: "200 g"),
              IngredientModel(name: "salt", amount: "to taste"),
            ]),
        MealModel(
            name: "Smoky Lentil Chili with Squash",
            photo:
                "https://www.themealdb.com/images/media/meals/uwxqwy1483389553.jpg",
            instruction:
                "Begin by roasting the squash. Slice it into thin crescents and drizzle with a little oil and sprinkle with sea salt. I added a fresh little sage I had in the fridge, but it unnecessary. Roast the squash a 205 C (400 F) for 20-30 minutes, flipping halfway through, until soft and golden. Let cool and chop into cubes. Meanwhile, rinse the lentils and cover them with water. Bring them to the boil then turn down to a simmer and let cook (uncovered) for 20-30 minutes, or until tender. Drain and set aside. While the lentils are cooking heat the 1 Tbsp. of oil on low in a medium pot. Add the onions and leeks and saut for 5 or so minutes, or until they begin to soften. Add the garlic next along with the cumin and coriander, cooking for a few more minutes. Add the remaining spices paprika, cinnamon, chilli, cocoa, Worcestershire sauce, salt, and oregano. Next add the can of tomatoes, the water or stock, and carrots. Let simmer, covered, for 20 minutes or until the veg is tender and the mixture has thickened up. You\u2019ll need to check on the pot periodically for a stir and a top of of liquid if needed. Add the lentils and chopped roasted squash. Let cook for 10 more minutes to heat through. Serve with sliced jalapeno, lime wedges, cilantro, green onions, and cashew sour cream. SIMPLE CASHEW SOUR CREAM 1 Cup Raw Unsalted Cashews Pinch Sea Salt 1 tsp. Apple Cider Vinegar Water Bring some water to the boil, and use it to soak the cashews for at least four hours. Alternatively, you can use cold water and let the cashews soak overnight, but I\u2019m forgetful/lazy, so often use the boil method which is much faster. After the cashews have soaked, drain them and add to a high speed blender. Begin to puree, slowly adding about 1/2 cup fresh water, until a creamy consistency is reached. You may need to add less or more water to reach the desired consistency. Add a pinch of sea salt and vinegar (or lemon juice).",
            ingredients: [
              IngredientModel(name: "Olive Oil", amount: "1 tbls"),
              IngredientModel(name: "Onion", amount: "1"),
              IngredientModel(name: "Leek", amount: "1 chopped"),
              IngredientModel(name: "Garlic", amount: "3 cloves"),
              IngredientModel(name: "Cumin", amount: "4 tsp ground "),
              IngredientModel(name: "Coriander", amount: "2 tsp ground"),
              IngredientModel(name: "Smoked Paprika", amount: "1 tsp"),
              IngredientModel(name: "Cinnamon", amount: "1/2 tsp"),
            ]),
        MealModel(
            name: "Rocky Road Fudge",
            photo:
                "https://www.themealdb.com/images/media/meals/vtxyxv1483567157.jpg",
            instruction:
                "Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray. Pour cup of the miniature marshmallows into the bottom of the lined baking dish. In a microwave-safe bowl, combine the chocolate chips and peanut butter. Microwave the chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted. Add the vanilla extract and stir well, until smooth. Reserve 2 tablespoons of the chopped almonds or peanuts, and set aside. Fold 1 cups of the miniature marshmallows and the remaining chopped nuts into the chocolate mixture. Transfer the chocolate mixture into the prepared pan and spread into an even layer. Immediately top with the reserved chopped nuts and the mallow bits or additional miniature marshmallows, if using. Refrigerate for 4 hours, or until set. Remove the fudge and wax paper from the pan. Carefully peel all of wax paper from the fudge. Cut the fudge into bite-sized pieces and serve.",
            ingredients: [
              IngredientModel(name: "Miniature Marshmallows", amount: "2 cups"),
              IngredientModel(name: "Chocolate Chips", amount: "3 cups"),
              IngredientModel(name: "Peanut Butter", amount: " cup"),
              IngredientModel(name: "Vanilla Extract", amount: "1 tsp"),
              IngredientModel(name: "Peanuts", amount: "1 cups"),
            ]),
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
            itemBuilder:
                (BuildContext recommendationContext, int recommendationIndex) {
              List<MealModel> meals = recommendations[recommendationIndex];
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
                      MealModel meal = meals[mealIndex];
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
                              MaterialPageRoute(
                                builder: (context) => MealScreen(
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

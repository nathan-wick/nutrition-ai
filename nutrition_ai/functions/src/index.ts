import {Food,} from "./types/Food";
import {Ingredient,} from "./types/Ingredient";
import {Measurement,} from "./types/Measurement";
import {Food as OldFood,} from "./types/old/Food";
import {Ingredient as OldIngredient,} from "./types/old/Ingredient";
import {IngredientNutrients as OldIngredientNutrients,} from "./types/old/IngredientNutrients";
import {getFirestore,} from "firebase-admin/firestore";
import {initializeApp,} from "firebase-admin/app";
import {onCall,} from "firebase-functions/v2/https";

// Import {User, UserSex, Goal, HabitFrequency} from "./user";

initializeApp();

const database = getFirestore();

/*
 *After updating these cloud functions,
 *run the following command in the root terminal:
 *firebase deploy --only functions
 */

exports.formatOldData = onCall(async () => {

    // Delete existing formatted data to prevent duplication

    // Get old data
    const oldFoodsSnapshot = await database.collection(`foods`,).get(),
        oldIngredientsSnapshot = await database.collection(`ingredients`,).get(),
        oldIngredientNutrientsSnapshot = await database.collection(`ingredient_nutrients`,).get(),
        oldFoods: OldFood[] = [],
        oldIngredients: OldIngredient[] = [],
        oldIngredientNutrients: OldIngredientNutrients[] = [],
        newFoods: Food[] = [];

    if (oldFoodsSnapshot.empty ||
        oldIngredientsSnapshot.empty ||
        oldIngredientNutrientsSnapshot.empty) {

        throw new Error(`Missing old data.`,);

    }

    oldFoodsSnapshot.forEach((oldFoodDocument,) => {

        oldFoods.push(oldFoodDocument.data() as OldFood,);

    },);
    oldIngredientsSnapshot.forEach((oldIngredientDocument,) => {

        oldIngredients.push(oldIngredientDocument.data() as OldIngredient,);

    },);
    oldIngredientNutrientsSnapshot.forEach((oldIngredientNutrientsDocument,) => {

        oldIngredientNutrients.push(oldIngredientNutrientsDocument.data() as OldIngredientNutrients,);

    },);

    // Format old data into new models
    oldFoods.forEach((oldFood,) => {

        const newFood: Food = {
            "category": oldFood.categoryName,
            "code": parseInt(
                oldFood.code,
                10,
            ),
            "description": oldFood.description,
            "ingredients": [],
            "name": oldFood.name,
        };
        newFoods.push(newFood,);

    },);
    oldIngredients.forEach((oldIngredient,) => {

        const weight: Measurement = {
            "amount": parseFloat(oldIngredient.weight,),
            "unit": `g`,
        },
            newIngredient: Ingredient = {
                "code": parseInt(
                    oldIngredient.code,
                    10,
                ),
                "moistureChange": oldIngredient.moistureChange,
                "name": oldIngredient.name,
                "nutrients": [],
                "retentionCode": oldIngredient.retentionCode,
                weight,
            };
        newFoods.find((newFood,) => newFood.code === parseInt(
            oldIngredient.foodCode,
            10,
        ),)?.ingredients.push(newIngredient,);

    },);

    // Send the new data to the database

},);

/*
 *Export const recommendNutrients = functions.https.onRequest( async (req: any, res: any) => {
 *  try {
 *    const userData: User = req.body;
 *
 *    if (userData.birthday === null || userData.height === null||
 *        userData.weight === null || userData.habits === null) {
 *      res.status(400).json({message: "Invalid parameters"});
 *      return;
 *    }
 *
 *    const nutrients = calculateNutrients(userData);
 *    res.status(200).json(nutrients);
 *  } catch (error) {
 *    console.error("Error:", error);
 *    res.status(500).send("Internal Server Error");
 *  }
 *});
 *
 *function calculateNutrients(user: User) {
 *  let basalMetabolicRate;
 *  let activityLevelMultiplier;
 *  let totalCalories;
 *
 *  if (user.sex === UserSex.xx) {
 *    if (user.weight?.value && user.height?.value) {
 *      const age = user.age();
 *      if (age !== null) {
 *        basalMetabolicRate = 88.362 + (13.397 * user.weight.value) + (4.799 * user.height.value) - (5.677 * age);
 *      } else {
 *        throw new Error("Invalid user age data for calculation");
 *      }
 *    } else {
 *      throw new Error("Invalid user weight or height data for calculation");
 *    }
 *  } else {
 *    if (user.weight?.value && user.height?.value) {
 *      const age = user.age();
 *      if (age !== null) {
 *        basalMetabolicRate = 447.593 + (9.247 * user.weight.value) + (3.098 * user.height.value) - (4.330 * age);
 *      } else {
 *        throw new Error("Invalid user age data for calculation");
 *      }
 *    } else {
 *      throw new Error("Invalid user weight or height data for calculation");
 *    }
 *  }
 *
 *  const exerciseHabit = user.habits?.find((habit) => habit.name === "exercise");
 *
 *  if (exerciseHabit) {
 *    switch (exerciseHabit.frequency) {
 *    case HabitFrequency.none:
 *      activityLevelMultiplier = 1.2; // Sedentary
 *      break;
 *    case HabitFrequency.light:
 *      activityLevelMultiplier = 1.375; // Lightly active
 *      break;
 *    case HabitFrequency.moderate:
 *      activityLevelMultiplier = 1.55; // Moderately active
 *      break;
 *    case HabitFrequency.very:
 *      activityLevelMultiplier = 1.725; // Very active
 *      break;
 *    case HabitFrequency.extra:
 *      activityLevelMultiplier = 1.9; // Extra active
 *      break;
 *    default:
 *      throw new Error("Invalid habit frequency");
 *    }
 *  } else {
 *    throw new Error("Exercise habit not found");
 *  }
 *
 *  totalCalories = basalMetabolicRate * activityLevelMultiplier;
 *
 *  const goalMultiplier = user.goal?.goal === Goal.gainMuscle ? 2.2 : 1.6;
 *
 *  const protein = (user.goal?.goal) ? goalMultiplier * (user.weight?.value || 0) : 0;
 *  const fat = 0.25 * totalCalories / 9;
 *  const carbohydrates = (totalCalories - (protein * 4) - (fat * 9)) / 4;
 *
 *  const nutrients = {
 *    protein,
 *    carbohydrates,
 *    fat,
 *  };
 *
 *  return nutrients;
 *}
 */

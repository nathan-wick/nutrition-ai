import * as usdaFoodsJSON from "./information/usda/foods.json";
import * as usdaIngredientNutrientsJSON from "./information/usda/ingredient_nutrients.json";
import * as usdaIngredientsJSON from "./information/usda/ingredients.json";
import {Food,} from "./types/Food";
import {Ingredient,} from "./types/Ingredient";
import {Nutrient,} from "./types/Nutrient";
import {Food as USDAFood,} from "./types/usda/Food";
import {Ingredient as USDAIngredient,} from "./types/usda/Ingredient";
import {IngredientNutrients as USDAIngredientNutrients,} from "./types/usda/IngredientNutrients";
import {getFirestore,} from "firebase-admin/firestore";
import {initializeApp,} from "firebase-admin/app";
import {onSchedule,} from "firebase-functions/v2/scheduler";


initializeApp();

const database = getFirestore();

exports.getUSDAInformation = onSchedule(
    {
        "memory": `1GiB`,
        "schedule": `0 0 * * *`,
        "timeoutSeconds": 120,
    },
    async () => {

        const usdaFoods: USDAFood[] = usdaFoodsJSON,
            // TODO Find a way to do this without casting (as)
            usdaIngredients: USDAIngredient[] = usdaIngredientsJSON as USDAIngredient[],
            usdaIngredientNutrients: USDAIngredientNutrients[] = usdaIngredientNutrientsJSON as USDAIngredientNutrients[],
            newFoods: Food[] = [],
            usdaFoodsReference = database.collection(`usdaFoods`,),
            usdaFoodsCollectionExists = (await usdaFoodsReference.limit(1,).get()).size > 0,
            formatUSDAInformation = () => {

                usdaFoods.forEach((usdaFood,) => {

                    const newFood: Food = {
                        "category": {
                            "code": Number(usdaFood.categoryCode,),
                            "name": usdaFood.categoryName,
                        },
                        "code": Number(usdaFood.code,),
                        "description": usdaFood.description,
                        "ingredients": [],
                        "name": usdaFood.name,
                    };
                    newFoods.push(newFood,);

                },);
                usdaIngredients.forEach((usdaIngredient,) => {

                    const newIngredient: Ingredient = {
                        "amount": {
                            "amount": Number(usdaIngredient.weight,),
                            "unit": `g`,
                        },
                        "code": Number(usdaIngredient.code,),
                        "moistureChange": Number(usdaIngredient.moistureChange,),
                        "name": usdaIngredient.name,
                        "nutrients": [],
                        "retentionCode": Number(usdaIngredient.retentionCode,),
                    };
                    newFoods.find((newFood,) => newFood.code === Number(usdaIngredient.foodCode,),)?.
                        ingredients.push(newIngredient,);

                },);
                usdaIngredientNutrients.forEach((usdaIngredientNutrient,) => {

                    const newNutrient: Nutrient = {
                        "amount": {
                            "amount": Number(usdaIngredientNutrient.nutrientValue,),
                            "unit": `g`,
                        },
                        "code": Number(usdaIngredientNutrient.nutrientCode,),
                        "name": usdaIngredientNutrient.nutrientName,
                    },
                        relatedUSDAIngredient = usdaIngredients.find((usdaIngredient,) => usdaIngredient.code === usdaIngredientNutrient.ingredientCode,);
                    if (relatedUSDAIngredient) {

                        newFoods.find((newFood,) => newFood.code === Number(relatedUSDAIngredient.foodCode,),)?.
                            ingredients.find((ingredient,) => ingredient.code === Number(usdaIngredientNutrient.ingredientCode,),)?.
                            nutrients.push(newNutrient,);

                    }

                },);

            },
            writeUSDAInformation = () => {

                newFoods.forEach(async (newFood,) => {

                    await usdaFoodsReference.doc(String(newFood.code,),).set(newFood,);

                },);

            };

        if (!usdaFoodsCollectionExists) {

            formatUSDAInformation();
            writeUSDAInformation();

        }

    },
);

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

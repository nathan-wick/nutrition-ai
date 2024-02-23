import * as usdaFoodsJSON from "../information/usda/foods.json";
import * as usdaIngredientNutrientsJSON from "../information/usda/ingredient_nutrients.json";
import * as usdaIngredientsJSON from "../information/usda/ingredients.json";
import {Food,} from "../types/Food";
import {Ingredient,} from "../types/Ingredient";
import {Nutrient,} from "../types/Nutrient";
import {Food as USDAFood,} from "../types/usda/Food";
import {Ingredient as USDAIngredient,} from "../types/usda/Ingredient";
import {IngredientNutrients as USDAIngredientNutrients,} from "../types/usda/IngredientNutrients";
import getNutrient from "./getNutrient";

export const getUSDAFoods = () => {

    const usdaFoods: USDAFood[] = usdaFoodsJSON,
        usdaIngredients: USDAIngredient[] = usdaIngredientsJSON as USDAIngredient[],
        usdaIngredientNutrients: USDAIngredientNutrients[] = usdaIngredientNutrientsJSON as USDAIngredientNutrients[],
        foods: Food[] = usdaFoods.map((usdaFood,) => {

            const ingredients: Ingredient[] = usdaIngredients.filter((usdaIngredient,) => usdaIngredient.foodCode === usdaFood.code,).map((usdaIngredient,) => {

                const nutrients: Nutrient[] = usdaIngredientNutrients.filter((usdaNutrient,) => usdaNutrient.ingredientCode === usdaIngredient.code,).map((usdaNutrient,) => {

                    const nutrient = getNutrient(Number(usdaNutrient.nutrientCode,),);
                    nutrient.amount = {
                        "amount": Number(usdaNutrient.nutrientValue,),
                        "unit": nutrient?.defaultMeasurementUnit ?? `g`,
                    };
                    return nutrient;

                },);
                return {
                    "amount": {
                        "amount": Number(usdaIngredient.weight,),
                        "unit": `g`,
                    },
                    "code": Number(usdaIngredient.code,),
                    "moistureChange": Number(usdaIngredient.moistureChange,),
                    "name": usdaIngredient.name,
                    nutrients,
                    "retentionCode": Number(usdaIngredient.retentionCode,),
                };

            },);
            return {
                "category": {
                    "code": Number(usdaFood.categoryCode,),
                    "name": usdaFood.categoryName,
                },
                "code": Number(usdaFood.code,),
                "description": usdaFood.description,
                ingredients,
                "name": usdaFood.name,
            };

        },);

    return foods;

};

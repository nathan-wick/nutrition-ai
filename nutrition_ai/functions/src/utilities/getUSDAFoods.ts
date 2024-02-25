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
        usdaIngredientNutrients: USDAIngredientNutrients[] = (usdaIngredientNutrientsJSON as USDAIngredientNutrients[]).filter((usdaIngredientNutrient,) => Number(usdaIngredientNutrient.nutrientValue,) > 0,),
        foods: Food[] = usdaFoods.map((usdaFood,) => {

            const ingredients: Ingredient[] = usdaIngredients.filter((usdaIngredient,) => usdaIngredient.foodCode === usdaFood.code,).map((usdaIngredient,) => {

                const nutrients: Nutrient[] = usdaIngredientNutrients.filter((usdaNutrient,) => usdaNutrient.ingredientCode === usdaIngredient.code,).map((usdaNutrient,) => {

                    const nutrient = getNutrient(Number(usdaNutrient.nutrientCode,),);
                    nutrient.amount = {
                        "amount": Number(usdaNutrient.nutrientValue,),
                        "unit": nutrient?.defaultMeasurementUnit ?? `g`,
                    };
                    return nutrient;

                },).
                    filter((nutrient,) => nutrient.name !== `unknown`,);
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

            },).
                filter((ingredient,) => ingredient.amount.amount > 0 && ingredient.nutrients.length > 0,);
            return {
                "category": {
                    "code": Number(usdaFood.categoryCode,),
                    "name": usdaFood.categoryName,
                },
                "code": `${Math.random().toString(36,).
                    slice(-6,)}-${usdaFood.code}`,
                "description": usdaFood.description,
                ingredients,
                "name": usdaFood.name,
            };

        },).
            filter((food,) => food.ingredients.length > 0 && food.category.code !== 9999,);
    return foods;

};

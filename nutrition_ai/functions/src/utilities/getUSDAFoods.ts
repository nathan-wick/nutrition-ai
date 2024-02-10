import * as usdaFoodsJSON from "../information/usda/foods.json";
import * as usdaIngredientNutrientsJSON from "../information/usda/ingredient_nutrients.json";
import * as usdaIngredientsJSON from "../information/usda/ingredients.json";
import {Food,} from "../types/Food";
import {Ingredient,} from "../types/Ingredient";
import {Nutrient,} from "../types/Nutrient";
import {Food as USDAFood,} from "../types/usda/Food";
import {Ingredient as USDAIngredient,} from "../types/usda/Ingredient";
import {IngredientNutrients as USDAIngredientNutrients,} from "../types/usda/IngredientNutrients";

const getUSDAFoods = () => {

    let foods: Food[] = [];
    const usdaFoods: USDAFood[] = usdaFoodsJSON,
        usdaIngredients: USDAIngredient[] = usdaIngredientsJSON as USDAIngredient[],
        usdaIngredientNutrients: USDAIngredientNutrients[] = usdaIngredientNutrientsJSON as USDAIngredientNutrients[],
        getFoods = () => usdaFoods.forEach((usdaFood,) => {

            const food: Food = {
                "category": {
                    "code": Number(usdaFood.categoryCode,),
                    "name": usdaFood.categoryName,
                },
                "code": Number(usdaFood.code,),
                "description": usdaFood.description,
                "ingredients": [],
                "name": usdaFood.name,
            };
            foods.push(food,);

        },),
        getIngredients = () => usdaIngredients.forEach((usdaIngredient,) => {

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
            foods.find((food,) => food.code === Number(usdaIngredient.foodCode,),)?.
                ingredients.push(newIngredient,);

        },),
        getNutrients = () => usdaIngredientNutrients.forEach((usdaIngredientNutrient,) => {

            if (Number(usdaIngredientNutrient.nutrientValue,) > 0) {

                const newNutrient: Nutrient = {
                    "amount": {
                        "amount": Number(usdaIngredientNutrient.nutrientValue,),
                        "unit": `g`,
                    },
                    "code": Number(usdaIngredientNutrient.nutrientCode,),
                    "description": ``,
                    "name": usdaIngredientNutrient.nutrientName,
                },
                    relatedUSDAIngredient = usdaIngredients.find((usdaIngredient,) => usdaIngredient.code === usdaIngredientNutrient.ingredientCode,);
                if (relatedUSDAIngredient) {

                    foods.find((food,) => food.code === Number(relatedUSDAIngredient.foodCode,),)?.
                        ingredients.find((ingredient,) => ingredient.code === Number(usdaIngredientNutrient.ingredientCode,),)?.
                        nutrients.push(newNutrient,);

                }

            }

        },),
        filterFoodsWithNutrients = () => {

            foods = foods.filter((food,) => {

                const nutrients: Nutrient[] = [];
                food.ingredients.forEach((ingredient,) => nutrients.push(...ingredient.nutrients,),);
                return nutrients.length > 0;

            },);

        };

    getFoods();
    getIngredients();
    getNutrients();
    filterFoodsWithNutrients();

    return foods;

};

export default getUSDAFoods;

import * as usdaIngredientNutrientsJSON from "../information/usda/ingredient_nutrients.json";
import {Nutrient,} from "../types/Nutrient";
import {IngredientNutrients as USDAIngredientNutrients,} from "../types/usda/IngredientNutrients";
import getNutrient from "./getNutrient";

const getUSDANutrients = () => {

    const usdaIngredientNutrients: USDAIngredientNutrients[] = usdaIngredientNutrientsJSON as USDAIngredientNutrients[],
        seenNutrientCodes = new Set<number>(),
        uniqueNutrients: Nutrient[] = [];
    usdaIngredientNutrients.forEach((usdaIngredientNutrient,) => {

        const nutrientCode = Number(usdaIngredientNutrient.nutrientCode,);
        if (!seenNutrientCodes.has(nutrientCode,)) {

            seenNutrientCodes.add(nutrientCode,);
            const nutrient = getNutrient(nutrientCode,);
            if (nutrient) {

                uniqueNutrients.push(nutrient,);

            }

        }

    },);
    return uniqueNutrients;

};

export default getUSDANutrients;

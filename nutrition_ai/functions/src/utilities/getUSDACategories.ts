import * as usdaFoodsJSON from "../information/usda/foods.json";
import {Category,} from "../types/Category";
import {Food as USDAFood,} from "../types/usda/Food";

const getUSDACategories = () => {

    const usdaFoods: USDAFood[] = usdaFoodsJSON,
        seenCategoryCodes = new Set<number>(),
        uniqueCategories: Category[] = [];

    usdaFoods.forEach((usdaFood,) => {

        const categoryCode = Number(usdaFood.categoryCode,);

        if (!seenCategoryCodes.has(categoryCode,)) {

            seenCategoryCodes.add(categoryCode,);

            const category: Category = {
                "code": categoryCode,
                "name": usdaFood.categoryName,
            };

            uniqueCategories.push(category,);

        }

    },);

    return uniqueCategories;

};

export default getUSDACategories;

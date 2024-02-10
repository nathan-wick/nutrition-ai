import {Food,} from "../types/Food";
import {Nutrient,} from "../types/Nutrient";

const getFoodsNutrients = (foods: Food[],) => {

    const nutrients: Nutrient[] = [],
        getFoodNutrients = (food: Food,) => food.ingredients.flatMap((ingredient,) => ingredient.nutrients,);

    foods.forEach((food,) => nutrients.push(...getFoodNutrients(food,),),);

    return nutrients;

};

export default getFoodsNutrients;

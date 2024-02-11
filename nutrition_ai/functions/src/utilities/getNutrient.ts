import * as nutrientsJSON from "../information/nutrients.json";
import {Nutrient,} from "../types/Nutrient";

const getNutrient = (code: number,) => {

    let nutrientCode = code;
    const nutrients: Nutrient[] = nutrientsJSON;
    switch (code) {

    case 435:
        nutrientCode = 417;
        break;
    case 573:
        nutrientCode = 323;
        break;
    case 578:
        nutrientCode = 418;
        break;
    default:
        break;

    }
    return nutrients.find((nutrient,) => nutrient.code === nutrientCode,);

};

export default getNutrient;

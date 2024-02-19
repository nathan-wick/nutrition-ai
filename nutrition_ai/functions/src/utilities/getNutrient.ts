import * as nutrientsJSON from "../information/nutrients.json";
import {Nutrient,} from "../types/Nutrient";

const getNutrient = (code: number,) => {

    let nutrientCode = code;
    const nutrients: Nutrient[] = nutrientsJSON;
    switch (code) {

    case 319:
    case 322:
    case 321:
    case 334:
        nutrientCode = 320;
        break;
    case 432:
        nutrientCode = 417;
        break;
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

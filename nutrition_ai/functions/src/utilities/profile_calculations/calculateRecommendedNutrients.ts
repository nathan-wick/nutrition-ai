import * as nutrientsJSON from "../../information/nutrients.json";
import {Nutrient,} from "../../types/Nutrient";
import {Profile,} from "../../types/Profile";
import {calculateAlphaLinolenicAcid,} from "../nutrient_calculations/calculateAlphaLinolenicAcid";
import {calculateCalcium,} from "../nutrient_calculations/calculateCalcium";
import {calculateCarbohydrate,} from "../nutrient_calculations/calculateCarbohydrate";
import {calculateCholine,} from "../nutrient_calculations/calculateCholine";
import {calculateCopper,} from "../nutrient_calculations/calculateCopper";
import {calculateDietaryFiber,} from "../nutrient_calculations/calculateDietaryFiber";
import {calculateDocosahexaenoicAcid,} from "../nutrient_calculations/calculateDocosahexaenoicAcid";
import {calculateEicosapentaenoicAcid,} from "../nutrient_calculations/calculateEicosapentaenoicAcid";
import {calculateEnergy,} from "../nutrient_calculations/calculateEnergy";
import {calculateFat,} from "../nutrient_calculations/calculateFat";
import {calculateFolate,} from "../nutrient_calculations/calculateFolate";
import {calculateFolicAcid,} from "../nutrient_calculations/calculateFolicAcid";
import {calculateIron,} from "../nutrient_calculations/calculateIron";
import {calculateLinoleicAcid,} from "../nutrient_calculations/calculateLinoleicAcid";
import {calculateLuteinZeaxanthin,} from "../nutrient_calculations/calculateLuteinZeaxanthin";
import {calculateLycopene,} from "../nutrient_calculations/calculateLycopene";
import {calculateMagnesium,} from "../nutrient_calculations/calculateMagnesium";
import {calculateMonounsaturatedFattyAcid,} from "../nutrient_calculations/calculateMonounsaturatedFattyAcid.ts";
import {calculateNiacin,} from "../nutrient_calculations/calculateNiacin";
import {calculatePhosphorus,} from "../nutrient_calculations/calculatePhosphorus";
import {calculatePolyunsaturatedFattyAcid,} from "../nutrient_calculations/calculatePolyunsaturatedFattyAcid";
import {calculatePotassium,} from "../nutrient_calculations/calculatePotassium";
import {calculateProtein,} from "../nutrient_calculations/calculateProtein";
import {calculateRiboflavin,} from "../nutrient_calculations/calculateRiboflavin";
import {calculateSaturatedFattyAcid,} from "../nutrient_calculations/calculateSaturatedFattyAcid";
import {calculateSelenium,} from "../nutrient_calculations/calculateSelenium";
import {calculateSugar,} from "../nutrient_calculations/calculateSugar";
import {calculateThiamin,} from "../nutrient_calculations/calculateThiamin";
import {calculateVitaminA,} from "../nutrient_calculations/calculateVitaminA";
import {calculateVitaminB12,} from "../nutrient_calculations/calculateVitaminB12";
import {calculateVitaminB6,} from "../nutrient_calculations/calculateVitaminB6";
import {calculateVitaminC,} from "../nutrient_calculations/calculateVitaminC";
import {calculateVitaminD,} from "../nutrient_calculations/calculateVitaminD";
import {calculateVitaminE,} from "../nutrient_calculations/calculateVitaminE";
import {calculateVitaminK,} from "../nutrient_calculations/calculateVitaminK";
import {calculateWater,} from "../nutrient_calculations/calculateWater";
import {calculateZinc,} from "../nutrient_calculations/calculateZinc";

export const calculateRecommendedNutrients = (profile: Profile,) => {

    const nutrients: Nutrient[] = nutrientsJSON,
        recommendedNutrients: Nutrient[] = [],
        recommendedNutrientCodes = [
            619,
            301,
            205,
            421,
            312,
            291,
            621,
            629,
            208,
            204,
            417,
            431,
            303,
            618,
            338,
            337,
            304,
            645,
            406,
            305,
            646,
            306,
            203,
            405,
            606,
            317,
            269,
            404,
            320,
            415,
            418,
            401,
            328,
            323,
            430,
            255,
            309,
        ],
        getAmount = (nutrientCode: number,) => {

            switch (nutrientCode) {

            case 619:
                return calculateAlphaLinolenicAcid(profile,);
            case 301:
                return calculateCalcium(profile,);
            case 205:
                return calculateCarbohydrate(profile,);
            case 421:
                return calculateCholine(profile,);
            case 312:
                return calculateCopper(profile,);
            case 291:
                return calculateDietaryFiber(profile,);
            case 621:
                return calculateDocosahexaenoicAcid(profile,);
            case 629:
                return calculateEicosapentaenoicAcid(profile,);
            case 208:
                return calculateEnergy(profile,);
            case 204:
                return calculateFat(profile,);
            case 417:
                return calculateFolate(profile,);
            case 431:
                return calculateFolicAcid(profile,);
            case 303:
                return calculateIron(profile,);
            case 618:
                return calculateLinoleicAcid(profile,);
            case 338:
                return calculateLuteinZeaxanthin(profile,);
            case 337:
                return calculateLycopene(profile,);
            case 304:
                return calculateMagnesium(profile,);
            case 645:
                return calculateMonounsaturatedFattyAcid(profile,);
            case 406:
                return calculateNiacin(profile,);
            case 305:
                return calculatePhosphorus(profile,);
            case 646:
                return calculatePolyunsaturatedFattyAcid(profile,);
            case 306:
                return calculatePotassium(profile,);
            case 203:
                return calculateProtein(profile,);
            case 405:
                return calculateRiboflavin(profile,);
            case 606:
                return calculateSaturatedFattyAcid(profile,);
            case 317:
                return calculateSelenium(profile,);
            case 269:
                return calculateSugar(profile,);
            case 404:
                return calculateThiamin(profile,);
            case 320:
                return calculateVitaminA(profile,);
            case 415:
                return calculateVitaminB6(profile,);
            case 418:
                return calculateVitaminB12(profile,);
            case 401:
                return calculateVitaminC(profile,);
            case 328:
                return calculateVitaminD(profile,);
            case 323:
                return calculateVitaminE(profile,);
            case 430:
                return calculateVitaminK(profile,);
            case 255:
                return calculateWater(profile,);
            case 309:
                return calculateZinc(profile,);
            default:
                return undefined;

            }

        };
    recommendedNutrientCodes.forEach((recommendedNutrientCode,) => {

        const recommendedNutrient = nutrients.find((nutrient,) => nutrient.code === recommendedNutrientCode,);
        if (recommendedNutrient) {

            const amount = getAmount(recommendedNutrientCode,);
            if (amount) {

                amount.amount = Math.round(amount.amount,);
                recommendedNutrient.amount = amount;
                recommendedNutrients.push(recommendedNutrient,);

            }

        }

    },);
    return recommendedNutrients;

};

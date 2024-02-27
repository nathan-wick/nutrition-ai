// TODO Enable one-var
/* eslint-disable one-var */
import {Food,} from "../types/Food";
import {User,} from "../types/User";

export const getRecommendedDailyFoods = (user: User,) => {

    const recommendedFoodsLimit = 30;

    // Get the recommended water amount.
    const recommendedWaterAmount = user.recommendedNutrients.find((recommendedNutrient,) => recommendedNutrient.code === 255,)?.amount ?? {
        "amount": 3785,
        "unit": `g`,
    };

    // Get some food to rank, starting with the user's approved foods.
    const foodsToRank = user.approvedFoods;
    if (foodsToRank.length < recommendedFoodsLimit) {

        // TODO Push random foods from the database to foodsToRank.

    }
    // TODO Sort foodsToRank into a random order

    const rankedFoods = foodsToRank.map((foodToRank,) => ({
            "food": foodToRank,
            // TODO Give rank (0 being the worst, 0.5 being average, and 1 being the best)
            "rank": 0,
        }),),
        recommendedDailyNutrients = user.recommendedNutrients.map((recommendedNutrient,) => ({
            "actualAmount": 0,
            "nutrientCode": recommendedNutrient.code,
            "recommendedAmount": recommendedNutrient.amount?.amount ?? 0,
            "unit": recommendedNutrient.amount?.unit ?? `g`,
        }),),
        recommendedDailyFoods: Food[] = [];

    // TODO Iterate through ranked foods and add them to recommendedDailyFoods. Track the total nutrients.

    /*
     * TODO If we are under the recommended nutrients, swap foods till we are at the recommended nutrients.
     * Foods with lowest rank get swapped out first.
     * If we run out of rankedFoods, get more random foods from the database.
     */

    // TODO Water stuff

    return recommendedDailyFoods;

};

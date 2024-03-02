// TODO Enable one-var
/* eslint-disable one-var */
import {Food,} from "../types/Food";
import {RankedFood,} from "../types/RankedFood";
import {User,} from "../types/User";
import {shuffleFoods,} from "./shuffleFoods";

export const getRecommendedDailyFoods = async (database: FirebaseFirestore.Firestore, user: User,) => {

    const maximumRecommendedFoods = 30,
        minimumRecommendedFoods = 20,
        recommendedWaterAmount = user.recommendedNutrients.find((recommendedNutrient,) => recommendedNutrient.code === 255,)?.amount ?? {
            "amount": 3785,
            "unit": `g`,
        },
        foodsToRank = user.approvedFoods,
        rankFood = (foodToRank: Food,) => {

            const allNutrients = foodToRank.ingredients.flatMap((ingredient,) => ingredient.nutrients,);
            return allNutrients.filter((nutrient,) => user.recommendedNutrients.some((recommendedNutrient,) => recommendedNutrient.code === nutrient.code,),).length;

        },
        recommendedDailyNutrients = user.recommendedNutrients.filter((recommendedNutrient,) => recommendedNutrient.code !== 255,).map((recommendedNutrient,) => ({
            "actualAmount": 0,
            "nutrientCode": recommendedNutrient.code,
            "recommendedAmount": recommendedNutrient.amount?.amount ?? 0,
            "unit": recommendedNutrient.amount?.unit ?? `g`,
        }),),
        recommendedDailyRankedFoods: RankedFood[] = [],
        recommendFood = (rankedFood: RankedFood,) => {

            if (recommendedDailyRankedFoods.length > maximumRecommendedFoods) {

                recommendedDailyRankedFoods.sort((food1, food2,) => food1.rank - food2.rank,);
                recommendedDailyRankedFoods.splice(
                    0,
                    1,
                );

            }
            recommendedDailyRankedFoods.push(rankedFood,);
            rankedFood.food.ingredients.forEach((ingredient,) => ingredient.nutrients.forEach((nutrient,) => {

                const recommendedNutrientToUpdate = recommendedDailyNutrients.find((recommendedDailyNutrient,) => recommendedDailyNutrient.nutrientCode === nutrient.code,);
                if (recommendedNutrientToUpdate) {

                    recommendedNutrientToUpdate.actualAmount += nutrient.amount?.amount ?? 0;

                }

            },),);

        };
    if (foodsToRank.length < minimumRecommendedFoods) {

        const randomFoodsFromDatabaseSnapshot = await database.collection(`usda_foods`,).where(
            `code`,
            `not-in`,
            [
                ...user.approvedFoods.map((approvedFood,) => approvedFood.code,),
                ...user.rejectedFoods.map((rejectedFood,) => rejectedFood.code,),
            ],
        ).
            orderBy(`code`,).
            limit(minimumRecommendedFoods - foodsToRank.length,).
            get();
        randomFoodsFromDatabaseSnapshot.forEach((document,) => foodsToRank.push(document.data() as Food,),);

    }
    const rankedFoods: RankedFood[] = shuffleFoods(foodsToRank,).map((foodToRank,) => ({
        "food": foodToRank,
        "rank": rankFood(foodToRank,),
    }),);

    // TODO Iterate through rankedFoods and run each rankedFood through recommendFood()

    rankedFoods.forEach(recommendFood,);

    // TODO Create function to get the currently recommendedFood's accuracy

    const calculateRecommendedFoodsAccuracy = () => {

        let totalNutrientAccuracy = 0;
        recommendedDailyNutrients.forEach((recommendedNutrient,) => {

            const {actualAmount, recommendedAmount,} = recommendedNutrient;
            const nutrientAccuracy = actualAmount / recommendedAmount;
            totalNutrientAccuracy += nutrientAccuracy;

        },);
        const averageAccuracy = totalNutrientAccuracy / recommendedDailyNutrients.length;
        return averageAccuracy;

    };

    const updateActualAmounts = () => {

        recommendedDailyNutrients.forEach((recommendedNutrient,) => {

            rankedFoods.forEach((rankedFood,) => {

                rankedFood.food.ingredients.forEach((ingredient,) => {

                    ingredient.nutrients.forEach((nutrient,) => {

                        if (nutrient.code === recommendedNutrient.nutrientCode) {

                            recommendedNutrient.actualAmount += nutrient.amount?.amount ?? 0;

                        }

                    },);

                },);

            },);

        },);

    };

    // TODO Repeat with new food until we meet a certain accuracy


    return recommendedDailyRankedFoods.map((recommendedDailyRankedFood,) => recommendedDailyRankedFood.food,);

};

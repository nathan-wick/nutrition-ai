import {Food,} from "../types/Food";
import {RankedFood,} from "../types/RankedFood";
import {User,} from "../types/User";
import {shuffleFoods,} from "./shuffleFoods";

export const getRecommendedDailyFoods = async (database: FirebaseFirestore.Firestore, user: User,) => {

    const maximumRecommendedFoods = 24,
        minimumRecommendedFoods = 14,
        maximumIterations = 4,
        recommendedDailyRankedFoods: RankedFood[] = [],
        recommendedDailyNutrients = user.recommendedNutrients.filter((recommendedNutrient,) => recommendedNutrient.code !== 255,).map((recommendedNutrient,) => ({
            "actualAmount": 0,
            "nutrientCode": recommendedNutrient.code,
            "recommendedAmount": recommendedNutrient.amount?.amount ?? 0,
            "unit": recommendedNutrient.amount?.unit ?? `g`,
        }),),
        recommendedWaterAmount = user.recommendedNutrients.find((recommendedNutrient,) => recommendedNutrient.code === 255,)?.amount ?? {
            "amount": 3785,
            "unit": `g`,
        },
        water: Food = {
            "category": {
                "code": 7702,
                "name": `Water`,
            },
            "code": `water`,
            "description": `filtered tap water; well water; water fountain; water bottled`,
            "ingredients": [
                {
                    "amount": recommendedWaterAmount,
                    "code": 14411,
                    "moistureChange": 0,
                    "name": `Water`,
                    "nutrients": [
                        {
                            "amount": recommendedWaterAmount,
                            "code": 255,
                            "defaultMeasurementUnit": `g`,
                            "name": `Water`,
                        },
                    ],
                    "retentionCode": 0,
                },
            ],
            "name": `Water`,
        },
        getRandomFoods = async (currentFoods: Food[],) => {

            let newFoods: Food[] = [],
                iterations = 0;
            const maximumGetRandomFoodIterations = 8;
            do {

                let iterationNewFoods: Food[] = [];
                const startCode = newFoods.length > 0
                        ? newFoods[newFoods.length - 1].code
                        : currentFoods.length > 0
                            ? currentFoods[currentFoods.length - 1].code
                            : undefined,
                    randomFoodsFromDatabaseSnapshot = startCode
                        // eslint-disable-next-line no-await-in-loop
                        ? await database.collection(`usda_foods`,).orderBy(`code`,).
                            // eslint-disable-next-line no-await-in-loop
                            startAfter(await database.collection(`usda_foods`,).doc(startCode,).
                                get(),).
                            limit(minimumRecommendedFoods,).
                            get()
                        // eslint-disable-next-line no-await-in-loop
                        : await database.collection(`usda_foods`,).orderBy(`code`,).
                            limit(minimumRecommendedFoods,).
                            get(),
                    codesToIgnore = new Set([
                        ...currentFoods.map((currentFood,) => currentFood.code,),
                        ...newFoods.map((newFood,) => newFood.code,),
                        ...user.rejectedFoods.map((rejectedFood,) => rejectedFood.code,),
                    ],);
                    // eslint-disable-next-line no-loop-func
                randomFoodsFromDatabaseSnapshot.forEach((document,) => iterationNewFoods.push(document.data() as Food,),);
                iterationNewFoods = iterationNewFoods.filter((newFood,) => !codesToIgnore.has(newFood.code,),);
                newFoods = [
                    ...newFoods,
                    ...iterationNewFoods,
                ];
                iterations += 1;

            } while (newFoods.length < minimumRecommendedFoods && iterations < maximumGetRandomFoodIterations);
            return [
                ...currentFoods,
                ...newFoods,
            ];

        },
        rankFood = (foodToRank: Food,) => {

            const allNutrients = foodToRank.ingredients.flatMap((ingredient,) => ingredient.nutrients,);
            return allNutrients.filter((nutrient,) => user.recommendedNutrients.some((recommendedNutrient,) => recommendedNutrient.code === nutrient.code,),).length;

        },
        recommendFood = (rankedFood: RankedFood,) => {

            if (recommendedDailyRankedFoods.length > maximumRecommendedFoods) {

                recommendedDailyRankedFoods.sort((food1, food2,) => food2.rank - food1.rank,);
                recommendedDailyRankedFoods.pop();

            }
            recommendedDailyRankedFoods.push(rankedFood,);
            rankedFood.food.ingredients.forEach((ingredient,) => ingredient.nutrients.forEach((nutrient,) => {

                const recommendedNutrientToUpdate = recommendedDailyNutrients.find((recommendedDailyNutrient,) => recommendedDailyNutrient.nutrientCode === nutrient.code,);
                if (recommendedNutrientToUpdate) {

                    recommendedNutrientToUpdate.actualAmount += nutrient.amount?.amount ?? 0;

                }

            },),);

        },
        calculateRecommendedDailyNutrientsAccuracy = () => {

            let totalNutrientAccuracy = 0;
            recommendedDailyNutrients.forEach((recommendedNutrient,) => {

                const {actualAmount, recommendedAmount,} = recommendedNutrient,
                    nutrientAccuracy = actualAmount / recommendedAmount;
                totalNutrientAccuracy += nutrientAccuracy;

            },);
            const averageAccuracy = totalNutrientAccuracy / recommendedDailyNutrients.length;
            return averageAccuracy;

        };
    let foods = user.approvedFoods,
        rankedFoods: RankedFood[] = [],
        iterations = 0;
    do {

        if (foods.length < minimumRecommendedFoods || iterations > 0) {

            // eslint-disable-next-line no-await-in-loop
            foods = await getRandomFoods(foods,);

        }
        rankedFoods = shuffleFoods(foods,).map((food,) => ({
            food,
            "rank": rankFood(food,),
        }),);
        rankedFoods.forEach((rankedFood,) => recommendFood(rankedFood,),);
        iterations += 1;

    } while (calculateRecommendedDailyNutrientsAccuracy() < 0.8 && iterations < maximumIterations);
    return [
        water,
        ...recommendedDailyRankedFoods.map((recommendedDailyRankedFood,) => recommendedDailyRankedFood.food,),
    ];

};

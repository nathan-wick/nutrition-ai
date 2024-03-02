import {Profile,} from "./types/Profile";
import {User,} from "./types/User";
import {calculateAge,} from "./utilities/profile_calculations/calculateAge";
import {calculateBodyMassIndex,} from "./utilities/profile_calculations/calculateBodyMassIndex";
import {calculateRecommendedNutrients,} from "./utilities/profile_calculations/calculateRecommendedNutrients";
import {calculateTotalDailyEnergyExpenditure,} from "./utilities/profile_calculations/calculateTotalDailyEnergyExpenditure";
import {getFirestore,} from "firebase-admin/firestore";
import {getRecommendedDailyFoods,} from "./utilities/getRecommendedDailyFoods";
import getUSDACategories from "./utilities/getUSDACategories";
import {getUSDAFoods,} from "./utilities/getUSDAFoods";
import {initializeApp,} from "firebase-admin/app";
import {onCall,} from "firebase-functions/v2/https";
import {onDocumentWritten,} from "firebase-functions/v2/firestore";
import {onSchedule,} from "firebase-functions/v2/scheduler";

initializeApp();
const maximumBatchSize = 500,
    database = getFirestore();

exports.getRecommendedDailyFoods = onCall(async (request,) => {

    const userId = String(request.auth?.uid,),
        userDocument = await database.collection(`users`,).doc(userId,).
            get();
    if (userDocument.exists) {

        const user = userDocument.data() as User;
        return getRecommendedDailyFoods(
            database,
            user,
        );

    }
    return [];

},);

exports.userChanged = onDocumentWritten(
    `users/{userId}`,
    // eslint-disable-next-line consistent-return
    (event,) => {

        if (event.data) {

            const profileBefore: Profile | undefined = event.data.before.data()?.profile,
                profileAfter: Profile | undefined = event.data.after.data()?.profile,
                profileChanged = profileBefore?.sex !== profileAfter?.sex ||
                    profileBefore?.height.amount !== profileAfter?.height.amount ||
                    profileBefore?.weight.amount !== profileAfter?.weight.amount ||
                    profileBefore?.exerciseFrequency !== profileAfter?.exerciseFrequency ||
                    profileBefore?.goal !== profileAfter?.goal;
            if (profileChanged && profileAfter) {

                const userAfter = event.data.after.data() as User;
                userAfter.profile.age = calculateAge(userAfter.profile.birthday,);
                userAfter.profile.bodyMassIndex = calculateBodyMassIndex(userAfter.profile,);
                userAfter.profile.totalDailyEnergyExpenditure = calculateTotalDailyEnergyExpenditure(userAfter.profile,);
                userAfter.recommendedNutrients = calculateRecommendedNutrients(userAfter.profile,);
                database.collection(`users`,).doc(event.params.userId,).
                    set(userAfter,);

            }

        }

    },
);

exports.getUSDAFoods = onSchedule(
    {
        "memory": `4GiB`,
        "schedule": `0 * * * *`,
        "timeoutSeconds": 300,
    },
    async () => {

        const usdaCollectionName = `usda_foods`,
            usdaCollectionExists = (await database.collection(usdaCollectionName,).limit(1,).
                get()).size > 0;
        if (!usdaCollectionExists) {

            const foods = getUSDAFoods(),
                foodBatches = [];
            while (foods.length > 0) {

                foodBatches.push(foods.splice(
                    0,
                    maximumBatchSize,
                ),);

            }
            await Promise.all(foodBatches.map(async (foodBatch,) => {

                const writeBatch = database.batch();
                foodBatch.forEach((food,) => {

                    const documentReference = database.collection(usdaCollectionName,).doc(food.code,);
                    writeBatch.set(
                        documentReference,
                        food,
                    );

                },);
                await writeBatch.commit();

            },),);

        }

    },
);

exports.getUSDACategories = onSchedule(
    {
        "memory": `4GiB`,
        "schedule": `0 * * * *`,
        "timeoutSeconds": 300,
    },
    async () => {

        const usdaCollectionName = `usda_categories`,
            usdaCollectionExists = (await database.collection(usdaCollectionName,).limit(1,).
                get()).size > 0;
        if (!usdaCollectionExists) {

            const categories = getUSDACategories(),
                categoryBatches = [];
            while (categories.length > 0) {

                categoryBatches.push(categories.splice(
                    0,
                    maximumBatchSize,
                ),);

            }
            await Promise.all(categoryBatches.map(async (categoryBatch,) => {

                const writeBatch = database.batch();
                categoryBatch.forEach((category,) => {

                    const documentReference = database.collection(usdaCollectionName,).doc(String(category.code,),);
                    writeBatch.set(
                        documentReference,
                        category,
                    );

                },);
                await writeBatch.commit();

            },),);

        }

    },
);

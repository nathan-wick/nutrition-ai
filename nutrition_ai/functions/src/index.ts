import {Profile,} from "./types/Profile";
import {User,} from "./types/User";
import {calculateRecommendedNutrients,} from "./utilities/calculateRecommendedNutrients";
import {getAge,} from "./utilities/getAge";
import {getBodyMassIndex,} from "./utilities/getBodyMassIndex";
import {getFirestore,} from "firebase-admin/firestore";
import {getTotalDailyEnergyExpenditure,} from "./utilities/getTotalDailyEnergyExpenditure";
import getUSDACategories from "./utilities/getUSDACategories";
import {getUSDAFoods,} from "./utilities/getUSDAFoods";
import {initializeApp,} from "firebase-admin/app";
import {onDocumentWritten,} from "firebase-functions/v2/firestore";
import {onSchedule,} from "firebase-functions/v2/scheduler";

initializeApp();
const maximumBatchSize = 500,
    database = getFirestore();

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
                userAfter.profile.age = getAge(userAfter.profile.birthday,);
                userAfter.profile.bodyMassIndex = getBodyMassIndex(userAfter.profile,);
                userAfter.profile.totalDailyEnergyExpenditure = getTotalDailyEnergyExpenditure(userAfter.profile,);
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

                    const randomFoodId = `${Math.random().toString(36,).
                            slice(-6,)}-${food.code}`,
                        documentReference = database.collection(usdaCollectionName,).doc(randomFoodId,);
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

        const usdaCollectionExists = (await database.collection(`usda_categories`,).limit(1,).
                get()).size > 0,
            writeUSDACategories = () => getUSDACategories().forEach(async (category,) => await database.collection(`usda_categories`,).doc(String(category.code,),).
                set(category,),);
        if (!usdaCollectionExists) {

            // TODO Rewrite getUSDACategories function to use batches
            writeUSDACategories();

        }

    },
);

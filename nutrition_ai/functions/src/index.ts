import {Profile,} from "./types/Profile";
import {User,} from "./types/User";
import {calculateRecommendedNutrients,} from "./utilities/calculateRecommendedNutrients";
import {getAge,} from "./utilities/getAge";
import {getBodyMassIndex,} from "./utilities/getBodyMassIndex";
import {getFirestore,} from "firebase-admin/firestore";
import {getTotalDailyEnergyExpenditure,} from "./utilities/getTotalDailyEnergyExpenditure";
import getUSDACategories from "./utilities/getUSDACategories";
import getUSDAFoods from "./utilities/getUSDAFoods";
import getUSDANutrients from "./utilities/getUSDANutrients";
import {initializeApp,} from "firebase-admin/app";
import {onDocumentWritten,} from "firebase-functions/v2/firestore";
import {onSchedule,} from "firebase-functions/v2/scheduler";

initializeApp();

const database = getFirestore();

exports.userChanged = onDocumentWritten(
    `users/{userId}`,
    (event,) => {

        if (event.data) {

            const profileBefore: Profile | undefined = event.data.before.data()?.profile,
                userAfter = event.data.after.data() as User,
                profileAfter: Profile | undefined = userAfter.profile,
                profileChanged = profileBefore !== profileAfter;
            if (profileChanged && profileAfter) {

                profileAfter.age = getAge(profileAfter.birthday,);
                profileAfter.bodyMassIndex = getBodyMassIndex(profileAfter,);
                profileAfter.totalDailyEnergyExpenditure = getTotalDailyEnergyExpenditure(profileAfter,);
                userAfter.recommendedNutrients = calculateRecommendedNutrients(profileAfter,);

            }
            return event.data.after.data()?.after.ref.set(
                userAfter,
                {"merge": true,},
            );

        }
        return undefined;

    },
);

exports.getUSDAFoods = onSchedule(
    {
        "memory": `4GiB`,
        "schedule": `0 * * * *`,
        "timeoutSeconds": 300,
    },
    async () => {

        const usdaCollectionExists = (await database.collection(`usda_foods`,).limit(1,).
                get()).size > 0,
            writeUSDAFoods = () => getUSDAFoods().forEach(async (food,) => await database.collection(`usda_foods`,).doc(String(food.code,),).
                set(food,),);
        if (!usdaCollectionExists) {

            writeUSDAFoods();

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

            writeUSDACategories();

        }

    },
);

exports.getUSDANutrients = onSchedule(
    {
        "memory": `4GiB`,
        "schedule": `0 * * * *`,
        "timeoutSeconds": 300,
    },
    async () => {

        const usdaCollectionExists = (await database.collection(`usda_nutrients`,).limit(1,).
                get()).size > 0,
            writeUSDANutrients = () => getUSDANutrients().forEach(async (nutrient,) => await database.collection(`usda_nutrients`,).doc(String(nutrient.code,),).
                set(nutrient,),);
        if (!usdaCollectionExists) {

            writeUSDANutrients();

        }

    },
);

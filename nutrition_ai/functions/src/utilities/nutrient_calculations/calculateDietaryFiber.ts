import {Profile,} from "../../types/Profile";

export const calculateDietaryFiber = (profile: Profile,) => {

    const fiberPer1000Calories = 14;
    let dailyFiberRecommendation = 0;
    if (profile.age && profile.age <= 50) {

        dailyFiberRecommendation = profile.sex === `female`
            ? 25
            : 38;

    } else {

        dailyFiberRecommendation = profile.sex === `female`
            ? 21
            : 30;

    }
    if (profile.bodyMassIndex && profile.bodyMassIndex >= 25 && profile.bodyMassIndex < 30) {

        dailyFiberRecommendation += 5;

    } else if (profile.bodyMassIndex && profile.bodyMassIndex >= 30) {

        dailyFiberRecommendation += 10;

    }
    if (profile.exerciseFrequency === `sometimes`) {

        dailyFiberRecommendation += 3;

    } else if (profile.exerciseFrequency === `often`) {

        dailyFiberRecommendation += 6;

    }
    dailyFiberRecommendation += profile.totalDailyEnergyExpenditure ?? 2500 / 1000 * fiberPer1000Calories;
    return {
        "amount": dailyFiberRecommendation,
        "unit": `g`,
    };

};

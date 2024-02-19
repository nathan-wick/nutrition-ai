import {Profile,} from "../../types/Profile";

export const calculateFat = (profile: Profile,) => {

    let targetFatPercentage = 0;
    switch (profile.goal) {

    case `lose_fat`:
        targetFatPercentage = 0.25;
        break;
    case `gain_muscle`:
        targetFatPercentage = 0.3;
        break;
    default:
        targetFatPercentage = 0.3;

    }
    const dailyFatCalories = profile.totalDailyEnergyExpenditure ?? 2500 * targetFatPercentage,
        dailyFatGrams = dailyFatCalories / 9;
    return {
        "amount": dailyFatGrams,
        "unit": `g`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculateSaturatedFattyAcid = (profile: Profile,) => {

    const saturatedFatPercentage = 0.07,
        saturatedFatCalories = profile.totalDailyEnergyExpenditure ?? 2500 * saturatedFatPercentage,
        saturatedFatGrams = saturatedFatCalories / 9;
    return {
        "amount": saturatedFatGrams,
        "unit": `g`,
    };

};

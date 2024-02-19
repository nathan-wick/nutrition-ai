import {Profile,} from "../../types/Profile";

export const calculateSugar = (profile: Profile,) => {

    const sugarCalories = profile.totalDailyEnergyExpenditure ?? 2500 * 0.07,
        sugarGrams = sugarCalories / 4;
    return {
        "amount": sugarGrams,
        "unit": `g`,
    };

};

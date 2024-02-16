import {Profile,} from "../../types/Profile";

export const calculatePolyunsaturatedFattyAcid = (profile: Profile,) => {

    const pufaPercentage = 0.07,
        pufaCalories = profile.totalDailyEnergyExpenditure ?? 2500 * pufaPercentage,
        pufaGrams = pufaCalories / 9;
    return {
        "amount": pufaGrams,
        "unit": `g`,
    };

};

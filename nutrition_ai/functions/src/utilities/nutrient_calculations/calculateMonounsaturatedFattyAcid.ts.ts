import {Profile,} from "../../types/Profile";

export const calculateMonounsaturatedFattyAcid = (profile: Profile,) => {

    const mufaCalories = profile.totalDailyEnergyExpenditure ?? 2500 * 0.18,
        mufaGrams = mufaCalories / 9;
    return {
        "amount": mufaGrams,
        "unit": `g`,
    };

};

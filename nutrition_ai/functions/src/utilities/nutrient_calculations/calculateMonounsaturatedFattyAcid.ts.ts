import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateMonounsaturatedFattyAcid = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,),
        mufaCalories = tdee * 0.18,
        mufaGrams = mufaCalories / 9;
    return {
        "amount": mufaGrams,
        "unit": `g`,
    };

};

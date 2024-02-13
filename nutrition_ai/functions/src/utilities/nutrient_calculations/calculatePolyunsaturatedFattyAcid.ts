import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculatePolyunsaturatedFattyAcid = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,),
        pufaPercentage = 0.07,
        pufaCalories = tdee * pufaPercentage,
        pufaGrams = pufaCalories / 9;
    return {
        "amount": pufaGrams,
        "unit": `g`,
    };

};

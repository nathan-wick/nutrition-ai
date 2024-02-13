import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateSugar = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,),
        sugarCalories = tdee * 0.07,
        sugarGrams = sugarCalories / 4;
    return {
        "amount": sugarGrams,
        "unit": `g`,
    };

};

import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateSaturatedFattyAcid = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,),
        saturatedFatPercentage = 0.07,
        saturatedFatCalories = tdee * saturatedFatPercentage,
        saturatedFatGrams = saturatedFatCalories / 9;
    return {
        "amount": saturatedFatGrams,
        "unit": `g`,
    };

};

import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateLinoleicAcid = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,),
        LINOLEIC_ACID_PERCENTAGE_OF_FATS = 0.05,
        RECOMMENDED_FAT_INTAKE = 0.3,
        dailyFatCalories = tdee * RECOMMENDED_FAT_INTAKE,
        dailyFatGrams = dailyFatCalories / 9,
        linoleicAcidGrams = dailyFatGrams * LINOLEIC_ACID_PERCENTAGE_OF_FATS;
    return {
        "amount": linoleicAcidGrams,
        "unit": `g`,
    };

};

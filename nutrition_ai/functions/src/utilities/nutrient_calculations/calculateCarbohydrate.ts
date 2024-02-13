import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateCarbohydrate = (profile: Profile,) => {

    let carbPercentage = 0;
    switch (profile.goal) {

    case `maintain`:
        carbPercentage = 0.5;
        break;
    case `lose_fat`:
        carbPercentage = 0.4;
        break;
    case `gain_fat`:
        carbPercentage = 0.6;
        break;
    case `gain_muscle`:
        carbPercentage = 0.55;
        break;
    default:
        carbPercentage = 0.5;

    }
    const tdee = getTotalDailyEnergyExpenditure(profile,),
        carbGrams = tdee * carbPercentage / 4;
    return {
        "amount": carbGrams,
        "unit": `g`,
    };

};

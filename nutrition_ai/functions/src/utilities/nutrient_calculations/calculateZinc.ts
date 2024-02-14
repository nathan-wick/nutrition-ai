import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateZinc = (profile: Profile,) => {

    let zincAmount = 0;
    switch (profile.goal) {

    case `lose_fat`:
        zincAmount = 18;
        break;
    case `gain_fat`:
        zincAmount = 20;
        break;
    case `gain_muscle`:
        zincAmount = 22;
        break;
    default:
        zincAmount = 15;
        break;

    }
    zincAmount *= getTotalDailyEnergyExpenditure(profile,) / 2000;
    return {
        "amount": zincAmount,
        "unit": `mg`,
    };

};

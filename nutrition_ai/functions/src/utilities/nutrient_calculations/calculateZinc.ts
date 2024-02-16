import {Profile,} from "../../types/Profile";

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
    zincAmount *= profile.totalDailyEnergyExpenditure ?? 2500 / 2500;
    return {
        "amount": zincAmount,
        "unit": `mg`,
    };

};

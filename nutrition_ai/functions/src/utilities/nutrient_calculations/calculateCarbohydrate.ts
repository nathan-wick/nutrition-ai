import {Profile,} from "../../types/Profile";

export const calculateCarbohydrate = (profile: Profile,) => {

    let carbPercentage = 0;
    switch (profile.goal) {

    case `maintain`:
        carbPercentage = 0.45;
        break;
    case `lose_fat`:
        carbPercentage = 0.3;
        break;
    case `gain_fat`:
        carbPercentage = 0.55;
        break;
    case `gain_muscle`:
        carbPercentage = 0.5;
        break;
    default:
        carbPercentage = 0.45;

    }
    return {
        "amount": profile.totalDailyEnergyExpenditure ?? 2500 * carbPercentage / 4,
        "unit": `g`,
    };

};

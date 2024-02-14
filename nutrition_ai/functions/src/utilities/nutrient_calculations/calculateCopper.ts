import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateCopper = (profile: Profile,) => {

    const COPPER_GOAL_MAINTAIN = 1.0,
        COPPER_GOAL_LOSE_FAT = 1.2,
        COPPER_GOAL_GAIN_FAT = 0.8,
        COPPER_GOAL_GAIN_MUSCLE = 1.5;
    let copperRequirement = 0,
        copperAmount = 0;
    switch (profile.goal) {

    case `lose_fat`:
        copperRequirement = COPPER_GOAL_LOSE_FAT;
        break;
    case `gain_fat`:
        copperRequirement = COPPER_GOAL_GAIN_FAT;
        break;
    case `gain_muscle`:
        copperRequirement = COPPER_GOAL_GAIN_MUSCLE;
        break;
    default:
        copperRequirement = COPPER_GOAL_MAINTAIN;
        break;

    }
    copperAmount = copperRequirement * getTotalDailyEnergyExpenditure(profile,);
    return {
        "amount": copperAmount,
        "unit": `mg`,
    };

};

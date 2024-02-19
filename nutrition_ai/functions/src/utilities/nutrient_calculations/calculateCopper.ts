import {Profile,} from "../../types/Profile";

export const calculateCopper = (profile: Profile,) => {

    const COPPER_RDA_ADULTS = 0.9,
        ADJUSTMENT_SEX = {
            "female": 1.1,
            "male": 1.0,
        },
        ADJUSTMENT_EXERCISE = {
            "never": 0.95,
            "often": 1.1,
            "sometimes": 1.0,
        },

        ADJUSTMENT_GOAL = {
            "gain_fat": 0.95,
            "gain_muscle": 1.2,
            "lose_fat": 1.05,
            "maintain": 1.0,
        };
    let copperRequirement = COPPER_RDA_ADULTS;
    copperRequirement *= ADJUSTMENT_SEX[profile.sex];
    copperRequirement *= ADJUSTMENT_EXERCISE[profile.exerciseFrequency];
    copperRequirement *= ADJUSTMENT_GOAL[profile.goal];
    if (profile.totalDailyEnergyExpenditure) {

        const COPPER_PER_CALORIE = 0.00035;
        copperRequirement += profile.totalDailyEnergyExpenditure * COPPER_PER_CALORIE;

    }
    return {
        "amount": copperRequirement,
        "unit": `mg`,
    };

};

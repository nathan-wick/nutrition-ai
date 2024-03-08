import {Profile,} from "../../types/Profile";

export const calculateEicosapentaenoicAcid = (profile: Profile,) => {

    let adjustmentFactor = 1.0,
        dailyEPA = 0;
    const baseRecommendations = {
            "gain_fat": 0.25,
            "gain_muscle": 0.75,
            "lose_fat": 0.5,
            "maintain": 0.25,
        },
        age = profile.age ?? 22;
    if (age >= 50) {

        adjustmentFactor *= 1.2;

    }
    if (profile.exerciseFrequency === `sometimes`) {

        adjustmentFactor *= 1.05;

    }
    if (profile.exerciseFrequency === `often`) {

        adjustmentFactor *= 1.1;

    }
    dailyEPA = baseRecommendations[profile.goal] * adjustmentFactor;
    if (profile.totalDailyEnergyExpenditure && profile.totalDailyEnergyExpenditure > 2500) {

        dailyEPA *= 1.25;

    }
    return {
        "amount": dailyEPA,
        "unit": `g`,
    };

};

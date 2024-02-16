import {Profile,} from "../../types/Profile";

export const calculateCholine = (profile: Profile,) => {

    const cholineAIs = {
            "female": 425,
            "male": 550,
        },

        adjustmentFactors = {
            "exerciseFrequency": {
                "never": 1.0,
                "often": 1.2,
                "sometimes": 1.1,
            },
            "goal": {
                "gain_fat": 1.05,
                "gain_muscle": 1.15,
                "lose_fat": 1.0,
                "maintain": 1.0,
            },
        };
    let cholineRequirement = cholineAIs[profile.sex];
    cholineRequirement *= adjustmentFactors.exerciseFrequency[profile.exerciseFrequency];
    cholineRequirement *= adjustmentFactors.goal[profile.goal];
    if (profile.totalDailyEnergyExpenditure) {

        if (profile.totalDailyEnergyExpenditure > 3000) {

            cholineRequirement *= 1.1;

        }

    }
    return {
        "amount": Math.round(cholineRequirement,),
        "unit": `mg`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculatePhosphorus = (profile: Profile,) => {

    const phosphorusRequirements = {
            "gain_fat": 800,
            "gain_muscle": 850,
            "lose_fat": 750,
            "maintain": 700,
        },
        exerciseMultiplier = {
            "never": 1,
            "often": 1.2,
            "sometimes": 1.1,
        },
        totalPhosphorus = phosphorusRequirements[profile.goal] * exerciseMultiplier[profile.exerciseFrequency];
    return {
        "amount": totalPhosphorus,
        "unit": `mg`,
    };

};

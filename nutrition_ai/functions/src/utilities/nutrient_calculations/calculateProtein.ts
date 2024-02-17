import {Profile,} from "../../types/Profile";

export const calculateProtein = (profile: Profile,) => {

    const weightInKilograms = profile.weight.amount * 0.453592,
        proteinPerKg = {
            "gain_fat": {
                "never": 0.8,
                "often": 1.2,
                "sometimes": 1.0,
            },
            "gain_muscle": {
                "never": 1.4,
                "often": 1.8,
                "sometimes": 1.6,
            },
            "lose_fat": {
                "never": 1.2,
                "often": 1.6,
                "sometimes": 1.4,
            },
            "maintain": {
                "never": 0.8,
                "often": 1.2,
                "sometimes": 1.0,
            },
        },
        proteinFactor = proteinPerKg[profile.goal][profile.exerciseFrequency],
        proteinGoalGrams = weightInKilograms * proteinFactor;
    return {
        "amount": proteinGoalGrams,
        "unit": `g`,
    };

};

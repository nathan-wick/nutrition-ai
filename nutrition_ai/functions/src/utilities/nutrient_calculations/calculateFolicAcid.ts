import {Profile,} from "../../types/Profile";

export const calculateFolicAcid = (profile: Profile,) => {

    const folicAcidGoals = {
            "gain_fat": 0.6,
            "gain_muscle": 0.7,
            "lose_fat": 0.5,
            "maintain": 0.4,
        },
        folicAcidAmount = folicAcidGoals[profile.goal];
    return {
        "amount": folicAcidAmount,
        "unit": `mg`,
    };

};

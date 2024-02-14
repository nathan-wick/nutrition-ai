import {Profile,} from "../../types/Profile";

export const calculateMagnesium = (profile: Profile,) => {

    const magnesiumRequirements = {
            "gain_fat": 250,
            "gain_muscle": 400,
            "lose_fat": 350,
            "maintain": 300,
        },
        magnesiumAmount = magnesiumRequirements[profile.goal];
    return {
        "amount": magnesiumAmount,
        "unit": `mg`,
    };

};

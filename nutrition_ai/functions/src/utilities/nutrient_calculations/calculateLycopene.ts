import {Profile,} from "../../types/Profile";

export const calculateLycopene = (profile: Profile,) => {

    const lycopeneRequirements = {
            "gain_fat": 8,
            "gain_muscle": 12,
            "lose_fat": 15,
            "maintain": 10,
        },
        sexAdjustment = profile.sex === `female`
            ? 0.8
            : 1,
        exerciseAdjustment = profile.exerciseFrequency === `often`
            ? 1.2
            : 1,
        totalLycopeneNeeds = lycopeneRequirements[profile.goal] * sexAdjustment * exerciseAdjustment;
    return {
        "amount": totalLycopeneNeeds,
        "unit": `mg`,
    };

};

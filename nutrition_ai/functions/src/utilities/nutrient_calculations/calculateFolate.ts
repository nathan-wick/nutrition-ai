import {Profile,} from "../../types/Profile";

export const calculateFolate = (profile: Profile,) => {

    const folateRequirements = {
            "gain_fat": 0.6,
            "gain_muscle": 0.7,
            "lose_fat": 0.5,
            "maintain": 0.4,
        },
        sexMultiplier = profile.sex === `female`
            ? 1.1
            : 1.0,
        exerciseMultiplier = profile.exerciseFrequency === `never`
            ? 0.9
            : profile.exerciseFrequency === `sometimes`
                ? 1.0
                : profile.exerciseFrequency === `often`
                    ? 1.1
                    : 1.0,
        totalFolateRequirement = folateRequirements[profile.goal] * sexMultiplier * exerciseMultiplier;
    return {
        "amount": totalFolateRequirement,
        "unit": `mg`,
    };

};

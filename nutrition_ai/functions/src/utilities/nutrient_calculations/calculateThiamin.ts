import {Profile,} from "../../types/Profile";

export const calculateThiamin = (profile: Profile,) => {

    const thiaminRequirements = {
            "gain_fat": 1.4,
            "gain_muscle": 1.6,
            "lose_fat": 1.2,
            "maintain": 1.0,
        },
        sexFactor = profile.sex === `female`
            ? 0.9
            : 1.0,
        exerciseFactor = {
            "never": 1.0,
            "often": 1.4,
            "sometimes": 1.2,
        }[profile.exerciseFrequency],
        totalThiaminRequirement = thiaminRequirements[profile.goal] * sexFactor * exerciseFactor;
    return {
        "amount": totalThiaminRequirement,
        "unit": `mg`,
    };

};

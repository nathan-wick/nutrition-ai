import {Profile,} from "../../types/Profile";

export const calculateLuteinZeaxanthin = (profile: Profile,) => {

    const baseRequirement = 10,
        additionalRequirement = profile.exerciseFrequency === `often`
            ? 5
            : 0;
    let goalMultiplier = 0,
        totalRequirement = 0;
    switch (profile.goal) {

    case `lose_fat`:
        goalMultiplier = 0.8;
        break;
    case `gain_fat`:
        goalMultiplier = 1.2;
        break;
    case `gain_muscle`:
        goalMultiplier = 1.5;
        break;
    default:
        goalMultiplier = 1;
        break;

    }
    totalRequirement = (baseRequirement + additionalRequirement) * goalMultiplier;
    return {
        "amount": totalRequirement,
        "unit": `mg`,
    };

};

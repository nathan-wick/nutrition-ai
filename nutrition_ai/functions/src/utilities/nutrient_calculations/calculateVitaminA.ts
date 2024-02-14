import {Profile,} from "../../types/Profile";

export const calculateVitaminA = (profile: Profile,) => {

    const VITAMIN_A_REQUIREMENT_PER_KG = 0.8,
        VITAMIN_A_CONVERSION_FACTOR = 0.001,
        weightInKg = profile.weight.amount / 2.20462;
    let vitaminARequirement = weightInKg * VITAMIN_A_REQUIREMENT_PER_KG;
    switch (profile.exerciseFrequency) {

    case `never`:
        vitaminARequirement *= 0.9;
        break;
    case `often`:
        vitaminARequirement *= 1.1;
        break;
    default:
        vitaminARequirement *= 1.0;
        break;

    }
    vitaminARequirement /= VITAMIN_A_CONVERSION_FACTOR;
    vitaminARequirement = Math.round(vitaminARequirement * 100,) / 100;
    return {
        "amount": vitaminARequirement,
        "unit": `mcg`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculateCalcium = (profile: Profile,) => {

    const calciumRequirements = {
            "gain_fat": 800,
            "gain_muscle": 1200,
            "lose_fat": 1200,
            "maintain": 1000,
        },
        sexFactor = profile.sex === `female`
            ? 1.2
            : 1.0,
        adjustedCalciumRequirement = calciumRequirements[profile.goal] * sexFactor,
        calciumFactor = (profile.height.amount + profile.weight.amount) / 100,
        finalCalciumRequirement = adjustedCalciumRequirement * calciumFactor;
    return {
        "amount": finalCalciumRequirement,
        "unit": `mg`,
    };

};

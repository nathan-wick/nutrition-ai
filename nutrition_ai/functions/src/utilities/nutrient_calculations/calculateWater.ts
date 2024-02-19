import {Profile,} from "../../types/Profile";

export const calculateWater = (profile: Profile,) => {

    let waterGoalInOz = profile.weight.amount / 2;
    if (profile.exerciseFrequency === `sometimes`) {

        waterGoalInOz += 16;

    } else if (profile.exerciseFrequency === `often`) {

        waterGoalInOz += 32;

    }
    if (profile.sex === `female`) {

        waterGoalInOz *= 0.9;

    }
    const waterGoalInGrams = waterGoalInOz * 29.5735;
    return {
        "amount": waterGoalInGrams,
        "unit": `g`,
    };

};

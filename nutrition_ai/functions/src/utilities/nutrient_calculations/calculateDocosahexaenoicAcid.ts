import {Profile,} from "../../types/Profile";

export const calculateDocosahexaenoicAcid = (profile: Profile,) => {

    const MIN_DHA_GRAMS = 0.25,
        DHA_PER_KG_MUSCLE_GAIN = 0.05;
    let targetDHA = MIN_DHA_GRAMS;
    if (profile.age && profile.age >= 50) {

        targetDHA += 0.1;

    }
    if (profile.sex === `female`) {

        targetDHA += 0.05;

    }
    switch (profile.exerciseFrequency) {

    case `often`:
        targetDHA += 0.2;
        break;
    case `sometimes`:
        targetDHA += 0.1;
        break;
    default:
        break;

    }
    if (profile.goal === `gain_muscle`) {

        // eslint-disable-next-line no-mixed-operators
        const desiredMuscleGainKg = (profile.totalDailyEnergyExpenditure ?? 2500 - profile.weight.amount * 10) / 7000;
        targetDHA += desiredMuscleGainKg * DHA_PER_KG_MUSCLE_GAIN;

    }
    targetDHA = Math.max(
        targetDHA,
        MIN_DHA_GRAMS,
    );
    targetDHA = Math.min(
        targetDHA,
        2,
    );
    return {
        "amount": targetDHA,
        "unit": `g`,
    };

};

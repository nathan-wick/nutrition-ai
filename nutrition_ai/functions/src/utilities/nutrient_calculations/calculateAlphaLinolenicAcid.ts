import {Profile,} from "../../types/Profile";

export const calculateAlphaLinolenicAcid = (profile: Profile,) => {

    const ALA_BASELINE_MALE = 1.6,
        ALA_BASELINE_FEMALE = 1.1;
    let baseRecommendation = profile.sex === `male`
            ? ALA_BASELINE_MALE
            : ALA_BASELINE_FEMALE,
        scalingFactor = 0;
    if (profile.age && profile.age >= 65) {

        baseRecommendation *= 1.05;

    }
    if (profile.exerciseFrequency === `sometimes`) {

        baseRecommendation *= 1.1;

    } else if (profile.exerciseFrequency === `often`) {

        baseRecommendation *= 1.2;

    }
    scalingFactor = Math.min(
        profile.totalDailyEnergyExpenditure ?? 2500 / 2500,
        1.2,
    );
    baseRecommendation *= scalingFactor;
    return {
        "amount": baseRecommendation,
        "unit": `g`,
    };

};

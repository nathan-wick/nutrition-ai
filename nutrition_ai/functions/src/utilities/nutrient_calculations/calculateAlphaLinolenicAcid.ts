import {Profile,} from "../../types/Profile";

export const calculateAlphaLinolenicAcid = (profile: Profile,) => {

    let baseRecommendation = profile.sex === `male`
        ? 1.6
        : 1.1;
    if (profile.exerciseFrequency === `sometimes`) {

        baseRecommendation *= 1.1;

    }
    if (profile.exerciseFrequency === `often`) {

        baseRecommendation *= 1.2;

    }
    return {
        "amount": baseRecommendation,
        "unit": `g`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculate = (profile: Profile,) => {

    const baseRecommendations = {
        "adultFemale": 0.25,
        "adultMale": 0.25,
        "breastfeeding": 0.3,
        "pregnant": 0.3,
    };
    let baseDHA = profile.sex === `male`
        ? baseRecommendations.adultMale
        : baseRecommendations.adultFemale;
    if (profile.exerciseFrequency === `often`) {

        baseDHA += 0.1;

    }
    if (profile.goal === `gain_muscle`) {

        baseDHA += 0.15;

    }
    return {
        "amount": baseDHA,
        "unit": `g`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculateRiboflavin = (profile: Profile,) => {

    const riboflavinRecommendation = 1.3;
    let riboflavinAmount = 0;
    switch (profile.goal) {

    case `lose_fat`:
        riboflavinAmount = riboflavinRecommendation + 0.2;
        break;
    case `gain_fat`:
        riboflavinAmount = riboflavinRecommendation - 0.2;
        break;
    case `gain_muscle`:
        riboflavinAmount = riboflavinRecommendation + 0.5;
        break;
    default:
        riboflavinAmount = riboflavinRecommendation;
        break;

    }
    return {
        "amount": riboflavinAmount,
        "unit": `mg`,
    };

};

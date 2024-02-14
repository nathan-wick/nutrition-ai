import {Profile,} from "../../types/Profile";

export const calculate = (profile: Profile,) => {

    const cholineAI = profile.sex === `male`
            ? 550
            : 425,
        cholineRequirement = cholineAI;
    return {
        "amount": cholineRequirement,
        "unit": `mg`,
    };

};

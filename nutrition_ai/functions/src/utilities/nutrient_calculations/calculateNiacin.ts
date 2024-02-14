import {Profile,} from "../../types/Profile";

export const calculateNiacin = (profile: Profile,) => {

    const niacinPerPound = 6;
    let niacinAmount = 0;
    switch (profile.goal) {

    case `lose_fat`:
        niacinAmount = profile.weight.amount * niacinPerPound * 1.1;
        break;
    case `gain_fat`:
        niacinAmount = profile.weight.amount * niacinPerPound * 0.9;
        break;
    case `gain_muscle`:
        niacinAmount = profile.weight.amount * niacinPerPound * 1.2;
        break;
    default:
        niacinAmount = profile.weight.amount * niacinPerPound;
        break;

    }
    return {
        "amount": niacinAmount,
        "unit": `mg`,
    };

};

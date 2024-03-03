import {Profile,} from "../../types/Profile";

export const calculateAlphaLinolenicAcid = (profile: Profile,) => {

    let amount = 0;
    if (profile.sex === `male`) {

        amount += 1.6;

    } else {

        amount += 1.1;

    }
    if (profile.exerciseFrequency === `often`) {

        amount += 0.2;

    } else if (profile.exerciseFrequency === `sometimes`) {

        amount += 0.1;

    }
    return {
        amount,
        "unit": `g`,
    };

};

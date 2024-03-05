import {Profile,} from "../../types/Profile";

export const calculateDietaryFiber = (profile: Profile,) => {

    let amount = 0;
    if (profile.sex === `male`) {

        amount = 38;

    } else {

        amount = 25;

    }
    if (profile.exerciseFrequency === `often`) {

        amount += 4;

    } else if (profile.exerciseFrequency === `sometimes`) {

        amount += 2;

    }
    if (profile.goal === `lose_fat`) {

        amount += 8;

    }
    return {
        amount,
        "unit": `g`,
    };

};

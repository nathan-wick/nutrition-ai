import {Profile,} from "../../types/Profile";

export const calculateCalcium = (profile: Profile,) => {

    const age = profile.age ?? 22;
    let amount = 0;
    if (age < 19) {

        amount += 300;

    } else if (age < 51) {

        amount += 1000;

    } else if (age < 71) {

        if (profile.sex === `male`) {

            amount += 1000;

        } else {

            amount += 1200;

        }

    } else {

        amount += 1200;

    }
    if (profile.exerciseFrequency === `often`) {

        amount += 200;

    } else if (profile.exerciseFrequency === `sometimes`) {

        amount += 100;

    }
    if (profile.bodyMassIndex ?? 0 > 30) {

        amount += 100;

    }
    if (profile.goal === `gain_muscle`) {

        amount += 200;

    }
    return {
        amount,
        "unit": `mg`,
    };

};

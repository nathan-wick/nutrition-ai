import {Profile,} from "../../types/Profile";

export const calculateCholine = (profile: Profile,) => {

    let amount = 0;
    if (profile.sex === `male`) {

        amount = 425;

    } else {

        amount = 450;

    }
    if (profile.age ?? 22 < 19) {

        amount -= 50;

    }
    return {
        amount,
        "unit": `mg`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculateCopper = (profile: Profile,) => {

    let amount = 0;
    if (profile.age ?? 22 < 19) {

        amount = 0.89;

    } else {

        amount = 0.9;

    }
    return {
        amount,
        "unit": `mg`,
    };

};

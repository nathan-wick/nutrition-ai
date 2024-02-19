import {Profile,} from "../../types/Profile";

export const calculateVitaminK = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age >= 1 && profile.age <= 3) {

        requirement = 30;

    } else if (profile.age && profile.age >= 4 && profile.age <= 8) {

        requirement = 55;

    } else if (profile.age && profile.age >= 9 && profile.age <= 13) {

        requirement = 60;

    } else if (profile.age && profile.age >= 14 && profile.age <= 18) {

        requirement = 75;

    } else {

        requirement = profile.sex === `male`
            ? 120
            : 90;

    }
    return {
        "amount": requirement,
        "unit": `mcg`,
    };

};

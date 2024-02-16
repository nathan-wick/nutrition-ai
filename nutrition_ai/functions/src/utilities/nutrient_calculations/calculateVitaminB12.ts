import {Profile,} from "../../types/Profile";

export const calculateVitaminB12 = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age >= 1 && profile.age <= 3) {

        requirement = 0.9;

    } else if (profile.age && profile.age >= 4 && profile.age <= 8) {

        requirement = 1.2;

    } else if (profile.age && profile.age >= 9 && profile.age <= 13) {

        requirement = 1.8;

    } else if (profile.age && profile.age >= 14 && profile.age <= 18) {

        requirement = 2.4;

    } else {

        requirement = 2.4;

    }
    return {
        "amount": requirement,
        "unit": `mcg`,
    };

};

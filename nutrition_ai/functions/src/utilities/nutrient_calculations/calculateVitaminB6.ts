import {Profile,} from "../../types/Profile";

export const calculateVitaminB6 = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age >= 1 && profile.age <= 3) {

        requirement = profile.sex === `male`
            ? 0.5
            : 0.5;

    } else if (profile.age && profile.age >= 4 && profile.age <= 8) {

        requirement = profile.sex === `male`
            ? 0.6
            : 0.6;

    } else if (profile.age && profile.age >= 9 && profile.age <= 13) {

        requirement = profile.sex === `male`
            ? 1.0
            : 1.0;

    } else if (profile.age && profile.age >= 14 && profile.age <= 18) {

        requirement = profile.sex === `male`
            ? 1.3
            : 1.2;

    } else if (profile.age && profile.age >= 19 && profile.age <= 150) {

        requirement = profile.sex === `male`
            ? 1.3
            : 1.3;

    } else {

        requirement = profile.sex === `male`
            ? 1.7
            : 1.5;

    }
    return {
        "amount": requirement,
        "unit": `mg`,
    };

};

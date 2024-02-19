import {Profile,} from "../../types/Profile";

export const calculateVitaminC = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age >= 1 && profile.age <= 3) {

        requirement = 15;

    } else if (profile.age && profile.age >= 4 && profile.age <= 8) {

        requirement = 25;

    } else if (profile.age && profile.age >= 9 && profile.age <= 13) {

        requirement = 45;

    } else if (profile.age && profile.age >= 14 && profile.age <= 18) {

        requirement = profile.sex === `male`
            ? 75
            : 65;

    } else {

        requirement = profile.sex === `male`
            ? 90
            : 75;

    }
    return {
        "amount": requirement,
        "unit": `mg`,
    };

};

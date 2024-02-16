import {Profile,} from "../../types/Profile";

export const calculateVitaminE = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age >= 0 && profile.age < 6) {

        requirement = 4;

    } else if (profile.age && profile.age >= 6 && profile.age < 12) {

        requirement = 5;

    } else if (profile.age && profile.age >= 12 && profile.age < 48) {

        requirement = 6;

    } else if (profile.age && profile.age >= 48 && profile.age < 96) {

        requirement = 7;

    } else if (profile.age && profile.age >= 96 && profile.age < 156) {

        requirement = 11;

    } else if (profile.age && profile.age >= 156 && profile.age < 228) {

        requirement = 15;

    } else {

        requirement = 15;

    }
    return {
        "amount": requirement,
        "unit": `mg`,
    };

};

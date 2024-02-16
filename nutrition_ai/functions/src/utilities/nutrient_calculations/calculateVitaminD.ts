import {Profile,} from "../../types/Profile";

export const calculateVitaminD = (profile: Profile,) => {

    let requirement = 0;
    if (profile.age && profile.age > 70) {

        requirement = 20;

    } else {

        requirement = 15;

    }
    return {
        "amount": requirement,
        "unit": `mcg`,
    };

};

import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminB6 = (profile: Profile,) => {

    const age = getAge(profile.birthday,);
    let requirement = 0;
    if (age >= 1 && age <= 3) {

        requirement = profile.sex === `male`
            ? 0.5
            : 0.5;

    } else if (age >= 4 && age <= 8) {

        requirement = profile.sex === `male`
            ? 0.6
            : 0.6;

    } else if (age >= 9 && age <= 13) {

        requirement = profile.sex === `male`
            ? 1.0
            : 1.0;

    } else if (age >= 14 && age <= 18) {

        requirement = profile.sex === `male`
            ? 1.3
            : 1.2;

    } else if (age >= 19 && age <= 150) {

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

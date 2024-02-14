import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminC = (profile: Profile,) => {

    let requirement = 0;
    const age = getAge(profile.birthday,);
    if (age >= 1 && age <= 3) {

        requirement = 15;

    } else if (age >= 4 && age <= 8) {

        requirement = 25;

    } else if (age >= 9 && age <= 13) {

        requirement = 45;

    } else if (age >= 14 && age <= 18) {

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

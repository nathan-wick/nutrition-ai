import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminK = (profile: Profile,) => {

    let requirement = 0;
    const age = getAge(profile.birthday,);
    if (age >= 1 && age <= 3) {

        requirement = 30;

    } else if (age >= 4 && age <= 8) {

        requirement = 55;

    } else if (age >= 9 && age <= 13) {

        requirement = 60;

    } else if (age >= 14 && age <= 18) {

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

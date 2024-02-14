import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminB12 = (profile: Profile,) => {

    const age = getAge(profile.birthday,);
    let requirement = 0;
    if (age >= 1 && age <= 3) {

        requirement = 0.9;

    } else if (age >= 4 && age <= 8) {

        requirement = 1.2;

    } else if (age >= 9 && age <= 13) {

        requirement = 1.8;

    } else if (age >= 14 && age <= 18) {

        requirement = 2.4;

    } else {

        requirement = 2.4;

    }
    return {
        "amount": requirement,
        "unit": `mcg`,
    };

};

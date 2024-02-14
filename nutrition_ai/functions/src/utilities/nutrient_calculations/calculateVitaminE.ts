import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminE = (profile: Profile,) => {

    const age = getAge(profile.birthday,);
    let requirement = 0;
    if (age >= 0 && age < 6) {

        requirement = 4;

    } else if (age >= 6 && age < 12) {

        requirement = 5;

    } else if (age >= 12 && age < 48) {

        requirement = 6;

    } else if (age >= 48 && age < 96) {

        requirement = 7;

    } else if (age >= 96 && age < 156) {

        requirement = 11;

    } else if (age >= 156 && age < 228) {

        requirement = 15;

    } else {

        requirement = 15;

    }
    return {
        "amount": requirement,
        "unit": `mg`,
    };

};

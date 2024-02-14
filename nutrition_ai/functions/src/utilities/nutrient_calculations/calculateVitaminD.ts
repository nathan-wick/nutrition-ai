import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateVitaminD = (profile: Profile,) => {

    let requirement = 0;
    const age = getAge(profile.birthday,);
    if (age > 70) {

        requirement = 20;

    } else {

        requirement = 15;

    }
    return {
        "amount": requirement,
        "unit": `mcg`,
    };

};

import {Profile,} from "../types/Profile";
import {getAge,} from "./getAge";

export const getBasalMetabolicRate = (profile: Profile,) => {

    if (profile.sex === `male`) {

        // eslint-disable-next-line no-extra-parens
        return (10 * profile.weight.amount / 2.205) + (6.25 * profile.height.amount * 2.54) - (5 * getAge(profile.birthday,)) + 5;

    }
    // eslint-disable-next-line no-extra-parens
    return (10 * profile.weight.amount / 2.205) + (6.25 * profile.height.amount * 2.54) - (5 * getAge(profile.birthday,)) - 161;


};

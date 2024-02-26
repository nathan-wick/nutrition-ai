import {Profile,} from "../../types/Profile";

export const calculateBasalMetabolicRate = (profile: Profile,) => {

    if (profile.sex === `male`) {

        // eslint-disable-next-line no-extra-parens
        return (10 * profile.weight.amount / 2.205) + (6.25 * profile.height.amount * 2.54) - (5 * (profile.age ?? 20)) + 5;

    }
    // eslint-disable-next-line no-extra-parens
    return (10 * profile.weight.amount / 2.205) + (6.25 * profile.height.amount * 2.54) - (5 * (profile.age ?? 20)) - 161;


};

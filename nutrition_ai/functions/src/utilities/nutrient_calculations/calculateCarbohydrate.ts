import {Profile,} from "../../types/Profile";
import {calculateEnergy,} from "./calculateEnergy";

export const calculateCarbohydrate = (profile: Profile,) => {

    const amount = calculateEnergy(profile,).amount / 2 / 4;
    return {
        amount,
        "unit": `g`,
    };

};

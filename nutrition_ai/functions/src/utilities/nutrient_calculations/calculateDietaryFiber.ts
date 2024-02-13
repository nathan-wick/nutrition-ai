import {Profile,} from "../../types/Profile";
import {getAge,} from "../getAge";

export const calculateDietaryFiber = (profile: Profile,) => {

    let baseFiberRequirement = 0;
    if (profile.sex === `female`) {

        baseFiberRequirement = 25;

    } else {

        baseFiberRequirement = 38;

    }
    if (getAge(profile.birthday,) > 50) {

        baseFiberRequirement -= 5;

    }
    if (profile.exerciseFrequency === `often`) {

        baseFiberRequirement += 5;

    }
    if (profile.goal === `lose_fat`) {

        baseFiberRequirement += 5;

    }
    return {
        "amount": baseFiberRequirement,
        "unit": `g`,
    };

};

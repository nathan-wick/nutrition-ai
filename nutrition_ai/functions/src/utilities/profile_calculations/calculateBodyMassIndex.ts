import {Profile,} from "../../types/Profile";

export const calculateBodyMassIndex = (profile: Profile,) => {

    const weightInKilograms = profile.weight.amount * 0.453592,
        heightInMeters = profile.height.amount * 0.0254;
    return weightInKilograms / (heightInMeters * heightInMeters);

};

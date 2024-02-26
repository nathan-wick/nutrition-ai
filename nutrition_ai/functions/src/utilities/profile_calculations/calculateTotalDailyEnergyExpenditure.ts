import {Profile,} from "../../types/Profile";
import {calculateBasalMetabolicRate,} from "./calculateBasalMetabolicRate";

export const calculateTotalDailyEnergyExpenditure = (profile: Profile,) => {

    let activityMultiplier = 0;
    switch (profile.exerciseFrequency) {

    case `never`:
        activityMultiplier = 1.2;
        break;
    case `sometimes`:
        activityMultiplier = 1.375;
        break;
    case `often`:
        activityMultiplier = 1.55;
        break;
    default:
        activityMultiplier = 1.375;

    }
    const bmr = calculateBasalMetabolicRate(profile,),
        tdee = bmr * activityMultiplier;
    return tdee;

};

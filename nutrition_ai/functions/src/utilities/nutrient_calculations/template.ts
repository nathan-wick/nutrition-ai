import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculate = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,);

};

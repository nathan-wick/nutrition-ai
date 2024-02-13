import {Profile,} from "../../types/Profile";
import {getTotalDailyEnergyExpenditure,} from "../getTotalDailyEnergyExpenditure";

export const calculateEnergy = (profile: Profile,) => {

    const tdee = getTotalDailyEnergyExpenditure(profile,);
    let energyNeeds = 0;
    switch (profile.goal) {

    case `maintain`:
        energyNeeds = tdee;
        break;
    case `lose_fat`:
        energyNeeds = tdee - 500;
        break;
    case `gain_fat`:
        energyNeeds = tdee + 500;
        break;
    case `gain_muscle`:
        energyNeeds = tdee + 250;
        break;
    default:
        energyNeeds = tdee;

    }
    return {
        "amount": Math.round(energyNeeds,),
        "unit": `kcal`,
    };

};

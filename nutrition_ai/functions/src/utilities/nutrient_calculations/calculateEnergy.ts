import {Profile,} from "../../types/Profile";

export const calculateEnergy = (profile: Profile,) => {

    let energyNeeds = 0;
    switch (profile.goal) {

    case `maintain`:
        energyNeeds = profile.totalDailyEnergyExpenditure ?? 2500;
        break;
    case `lose_fat`:
        energyNeeds = profile.totalDailyEnergyExpenditure ?? 2500 - 500;
        break;
    case `gain_fat`:
        energyNeeds = profile.totalDailyEnergyExpenditure ?? 2500 + 500;
        break;
    case `gain_muscle`:
        energyNeeds = profile.totalDailyEnergyExpenditure ?? 2500 + 250;
        break;
    default:
        energyNeeds = profile.totalDailyEnergyExpenditure ?? 2500;

    }
    return {
        "amount": Math.round(energyNeeds,),
        "unit": `kcal`,
    };

};

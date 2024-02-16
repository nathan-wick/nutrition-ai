import {Profile,} from "../../types/Profile";

export const calculateCalcium = (profile: Profile,) => {

    const sexFactor = profile.sex === `female`
            ? 1.2
            : 1.0,
        activityFactor = {
            "never": 1.0,
            "often": 1.2,
            "sometimes": 1.1,
        }[profile.exerciseFrequency];
    let calciumRDA = 1000,
        goalFactor = 1;
    if (profile.age && profile.age <= 50) {

        calciumRDA = 1000;

    } else if (profile.age && profile.age <= 70) {

        calciumRDA = 1200;

    } else {

        calciumRDA = 1300;

    }
    switch (profile.goal) {

    case `gain_muscle`:
        goalFactor = 1.2;
        break;
    case `lose_fat`:
        goalFactor = 1.1;
        break;
    default:
        goalFactor = 1;

    }
    return {
        "amount": calciumRDA * sexFactor * goalFactor * activityFactor,
        "unit": `mg`,
    };

};

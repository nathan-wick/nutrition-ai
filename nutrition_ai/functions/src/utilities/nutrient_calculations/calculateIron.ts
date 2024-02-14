import {Profile,} from "../../types/Profile";

export const calculate = (profile: Profile,) => {

    const ironGoalMap = {
            "gain_fat": 12,
            "gain_muscle": 14,
            "lose_fat": 10,
            "maintain": 8,
        },
        ironGoal = ironGoalMap[profile.goal];
    return {
        "amount": ironGoal,
        "unit": `mg`,
    };

};

import {Profile,} from "../../types/Profile";

export const calculate = (profile: Profile,) => {

    const POTASSIUM_GOALS = {
            "gain_fat": 4500,
            "gain_muscle": 5000,
            "lose_fat": 4000,
            "maintain": 3500,
        },
        POTASSIUM_RECOMMENDATION_PER_WEIGHT = 2.5,
        // eslint-disable-next-line no-extra-parens
        potassiumGoal = POTASSIUM_GOALS[profile.goal] + (profile.weight.amount * POTASSIUM_RECOMMENDATION_PER_WEIGHT);
    return {
        "amount": potassiumGoal,
        "unit": `mg`,
    };

};

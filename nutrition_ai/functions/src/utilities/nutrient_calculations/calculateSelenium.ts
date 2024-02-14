import {Profile,} from "../../types/Profile";

export const calculate = (profile: Profile,) => {

    const SELENIUM_PER_KG_MALE = 0.055,
        SELENIUM_PER_KG_FEMALE = 0.055,
        weightInKg = profile.weight.unit === `lbs`
            ? profile.weight.amount * 0.453592
            : profile.weight.amount,
        seleniumRequirement = profile.sex === `male`
            ? weightInKg * SELENIUM_PER_KG_MALE
            : weightInKg * SELENIUM_PER_KG_FEMALE;
    return {
        "amount": seleniumRequirement,
        "unit": `mg`,
    };

};

/* eslint-disable comma-dangle */
/* eslint-disable object-shorthand */
/* eslint-disable object-property-newline */
/* eslint-disable quote-props */
/* eslint-disable init-declarations */
/* eslint-disable one-var */
import {Profile} from "../types/Profile";

const getVitamins = (user: Profile,) => {

    const today = new Date();
    const birthDate = new Date(user.birthday,);
    const age = today.getFullYear() - birthDate.getFullYear();

    // VITAMINS
    const getVitaminA = () => {

        let requirement: number;
        const unit = `mcg`;

        // Determine the requirement based on age and gender
        if (age >= 1 && age <= 3) {

            requirement = user.sex === `male`
                ? 300
                : 300;

        } else if (age >= 4 && age <= 8) {

            requirement = 400;

        } else if (age >= 9 && age <= 13) {

            requirement = 600;

        } else {

            requirement = user.sex === `male`
                ? 900
                : 700;

        }

        return {amount: requirement, unit: unit};

    };

    const getVitaminC = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 15;

        } else if (age >= 4 && age <= 8) {

            requirement = 25;

        } else if (age >= 9 && age <= 13) {

            requirement = 45;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 75
                : 65;

        } else {

            requirement = user.sex === `male`
                ? 90
                : 75;

        }

        return {amount: requirement, unit: unit};

    };

    const getVitaminD = () => {

        let requirement: number;
        const unit = `mcg`;

        if (age > 70) {

            requirement = 20;

        } else {

            requirement = 15;

        }

        return {amount: requirement, unit: unit};

    };

    const getVitaminE = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 0 && age < 6) {

            requirement = 4;

        } else if (age >= 6 && age < 12) {

            requirement = 5;

        } else if (age >= 12 && age < 48) {

            requirement = 6;

        } else if (age >= 48 && age < 96) {

            requirement = 7;

        } else if (age >= 96 && age < 156) {

            requirement = 11;

        } else if (age >= 156 && age < 228) {

            requirement = 15;

        } else {

            requirement = 15;

        }

        return {amount: requirement, unit: unit};

    };

    const getVitaminK = () => {

        let requirement: number;
        const unit = `mcg`;

        if (age >= 1 && age <= 3) {

            requirement = 30;

        } else if (age >= 4 && age <= 8) {

            requirement = 55;

        } else if (age >= 9 && age <= 13) {

            requirement = 60;

        } else if (age >= 14 && age <= 18) {

            requirement = 75;

        } else {

            requirement = user.sex === `male`
                ? 120
                : 90;

        }

        return {amount: requirement, unit: unit};

    };

    // B VITAMINS
    const getVitaminB6 = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = user.sex === `male`
                ? 0.5
                : 0.5;

        } else if (age >= 4 && age <= 8) {

            requirement = user.sex === `male`
                ? 0.6
                : 0.6;

        } else if (age >= 9 && age <= 13) {

            requirement = user.sex === `male`
                ? 1.0
                : 1.0;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 1.3
                : 1.2;

        } else if (age >= 19 && age <= 150) {

            requirement = user.sex === `male`
                ? 1.3
                : 1.3;

        } else {

            requirement = user.sex === `male`
                ? 1.7
                : 1.5;

        }

        return {amount: requirement, unit: unit};

    };

    const getVitaminB12 = () => {

        let requirement: number;
        const unit = `mcg`;

        if (age >= 1 && age <= 3) {

            requirement = 0.9;

        } else if (age >= 4 && age <= 8) {

            requirement = 1.2;

        } else if (age >= 9 && age <= 13) {

            requirement = 1.8;

        } else if (age >= 14 && age <= 18) {

            requirement = 2.4;

        } else {

            requirement = 2.4;

        }

        return {amount: requirement, unit: unit};

    };

    const getBiotinRequirement = () => {

        let requirement: number;
        const unit = `mcg`;

        if (age >= 1 && age <= 3) {

            requirement = 8;

        } else if (age >= 4 && age <= 8) {

            requirement = 12;

        } else if (age >= 9 && age <= 13) {

            requirement = 20;

        } else if (age >= 14 && age <= 18) {

            requirement = 25;

        } else {

            requirement = 30;

        }

        return {amount: requirement, unit: unit};

    };

    const getFolateRequirement = () => {

        let requirement: number;

        // DFE (Dietary Folate Equivalent)
        const unit = `mcg`;

        if (age >= 1 && age <= 3) {

            requirement = 150;

        } else if (age >= 4 && age <= 8) {

            requirement = 200;

        } else if (age >= 9 && age <= 13) {

            requirement = 300;

        } else if (age >= 14 && age <= 18) {

            requirement = 400;

        } else {

            requirement = 400;

        }

        return {amount: requirement, unit: unit};

    };

    const getPantothenicAcidRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 2;

        } else if (age >= 4 && age <= 8) {

            requirement = 3;

        } else if (age >= 9 && age <= 13) {

            requirement = 4;

        } else if (age >= 14 && age <= 18) {

            requirement = 5;

        } else {

            requirement = 5;

        }

        return {amount: requirement, unit: unit};

    };

    const getThiaminRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 0.5;

        } else if (age >= 4 && age <= 8) {

            requirement = 0.6;

        } else if (age >= 9 && age <= 13) {

            requirement = 0.9;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 1.2
                : 1.0;

        } else {

            requirement = user.sex === `male`
                ? 1.2
                : 1.1;

        }

        return {amount: requirement, unit: unit};

    };

    const getRiboflavinRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 0.5;

        } else if (age >= 4 && age <= 8) {

            requirement = 0.6;

        } else if (age >= 9 && age <= 13) {

            requirement = 0.9;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 1.3
                : 1.0;

        } else {

            requirement = user.sex === `male`
                ? 1.3
                : 1.1;

        }

        return {amount: requirement, unit: unit};

    };

    const getNiacinRequirement = () => {

        let requirement: number;

        // NE (Niacin Equivalents)
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 6;

        } else if (age >= 4 && age <= 8) {

            requirement = 8;

        } else if (age >= 9 && age <= 13) {

            requirement = 12;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 16
                : 14;

        } else {

            requirement = user.sex === `male`
                ? 16
                : 14;

        }

        return {amount: requirement, unit: unit};

    };


    // MINERALS

    const getCalciumRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 700;

        } else if (age >= 4 && age <= 8) {

            requirement = 1000;

        } else if (age >= 9 && age <= 13) {

            requirement = 1300;

        } else if (age >= 14 && age <= 18) {

            requirement = 1300;

        } else if (age >= 19 && age <= 50) {

            requirement = 1000;

        } else if (age >= 51 && age <= 70) {

            requirement = user.sex === `male`
                ? 1000
                : 1200;

        } else {

            requirement = 1200;

        }

        return {amount: requirement, unit: unit};

    };

    const getMagnesiumRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 80;

        } else if (age >= 4 && age <= 8) {

            requirement = 130;

        } else if (age >= 9 && age <= 13) {

            requirement = 240;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 410
                : 360;

        } else if (age >= 19) {

            requirement = user.sex === `male`
                ? 400
                : 310;

        } else {

            requirement = 0;

        }

        return {amount: requirement, unit: unit};

    };

    const getPotassiumRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 2000;

        } else if (age >= 4 && age <= 8) {

            requirement = 2300;

        } else if (age >= 9 && age <= 13) {

            requirement = user.sex === `male`
                ? 2500
                : 2300;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 3000
                : 2300;

        } else if (age >= 19) {

            requirement = user.sex === `male`
                ? 3400
                : 2600;

        } else {

            requirement = 0;

        }

        return {amount: requirement, unit: unit};

    };

    const getIronRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 7;

        } else if (age >= 4 && age <= 8) {

            requirement = 10;

        } else if (age >= 9 && age <= 13) {

            requirement = 8;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 11
                : 15;

        } else if (age >= 19 && age <= 50) {

            requirement = user.sex === `male`
                ? 8
                : 18;

        } else {

            requirement = 8;

        }

        return {amount: requirement, unit: unit};

    };

    const getSodiumRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 800;

        } else if (age >= 4 && age <= 8) {

            requirement = 1000;

        } else {

            requirement = 1500;

        }

        return {amount: requirement, unit: unit};

    };

    const getChlorideRequirement = () => {

        let requirement: number;
        const unit = `g`;

        if (age >= 1 && age <= 3) {

            requirement = 1.5;

        } else if (age >= 4 && age <= 8) {

            requirement = 1.9;

        } else if (age >= 9 && age <= 13) {

            requirement = 2.3;

        } else if (age >= 14 && age <= 50) {

            requirement = 2.3;

        } else if (age >= 51 && age <= 70) {

            requirement = 2.0;

        } else {

            requirement = 1.8;

        }

        return {amount: requirement, unit: unit};

    };

    const getPhosphorusRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 460;

        } else if (age >= 4 && age <= 8) {

            requirement = 500;

        } else if (age >= 9 && age <= 13) {

            requirement = 1250;

        } else if (age >= 14 && age <= 18) {

            requirement = 1250;

        } else {

            requirement = 700;

        }

        return {amount: requirement, unit: unit};

    };

    const getZincRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 3;

        } else if (age >= 4 && age <= 8) {

            requirement = 5;

        } else if (age >= 9 && age <= 13) {

            requirement = 8;

        } else if (age >= 14 && age <= 18) {

            requirement = user.sex === `male`
                ? 11
                : 9;

        } else {

            requirement = user.sex === `male`
                ? 11
                : 8;

        }

        return {amount: requirement, unit: unit};

    };

    const getFluorideRequirement = () => {

        let requirement: number;
        const unit = `mg`;

        if (age >= 1 && age <= 3) {

            requirement = 0.7;

        } else if (age >= 4 && age <= 8) {

            requirement = 1;

        } else if (age >= 9 && age <= 13) {

            requirement = 2;

        } else if (age >= 14 && age <= 18) {

            requirement = 3;

        } else if (age >= 19) {

            requirement = user.sex === `male`
                ? 4
                : 3;

        } else {

            requirement = 0;

        }

        return {amount: requirement, unit: unit};

    };

    const getIodineRequirement = () => {

        let requirement: number;
        const unit = `mcg`;

        if (age >= 1 && age <= 8) {

            requirement = 90;

        } else if (age >= 9 && age <= 13) {

            requirement = 120;

        } else if (age >= 14 && age <= 18) {

            requirement = 150;

        } else {

            requirement = 150;

        }

        return {amount: requirement, unit: unit};

    };


};

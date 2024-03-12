import {Food,} from "../types/Food";

export const shuffleFoods = (array: Food[],) => {

    for (let object = array.length - 1; object > 0; object--) {

        const randomIndex = Math.floor(Math.random() * (object + 1),);
        [
            array[object],
            array[randomIndex],
        ] = [
            array[randomIndex],
            array[object],
        ];

    }
    return array;

};

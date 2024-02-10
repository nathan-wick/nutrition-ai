import {Food,} from "./Food";
import {Nutrient,} from "./Nutrient";
import {Profile,} from "./Profile";

export declare interface User {
    name: string,
    email: string,
    photo: string,
    profile: Profile,
    approvedFoods: Food[],
    rejectedFoods: Food[],
    minimumNutrients: Nutrient[],
    maximumNutrients: Nutrient[],
}

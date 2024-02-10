import {Food,} from "./Food";
import {Profile,} from "./Profile";

export declare interface User {
    name: string,
    email: string,
    photo: string,
    profile: Profile,
    approvedFoods: Food[],
    rejectedFoods: Food[],
}

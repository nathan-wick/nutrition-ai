import {Food,} from "./Food";
import {Measurement,} from "./Measurement";

export declare interface User {
    name: string,
    email: string,
    photo: string,
    birthday: Date,
    sex: `male` | `female`,
    height: Measurement,
    weight: Measurement,
    exerciseFrequency: `never` | `sometimes` | `often`,
    goal: `maintain` | `lose_fat` | `gain_fat` | `gain_muscle`,
    approvedFoods: Food[],
    rejectedFoods: Food[],
}

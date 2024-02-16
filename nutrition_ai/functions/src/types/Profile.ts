import {Measurement,} from "./Measurement";

export declare interface Profile {
    birthday: Date,
    sex: `male` | `female`,
    height: Measurement,
    weight: Measurement,
    exerciseFrequency: `never` | `sometimes` | `often`,
    goal: `maintain` | `lose_fat` | `gain_fat` | `gain_muscle`,
    age?: number,
    bmi?: number,
    totalDailyEnergyExpenditure?: number,
}

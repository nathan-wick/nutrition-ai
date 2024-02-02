import {Measurement,} from "./Measurement";

export declare interface Nutrient {
    code: number,
    name: string,
    // In grams
    amount: Measurement;
}

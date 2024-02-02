import {Measurement,} from "./Measurement";
import {Nutrient,} from "./Nutrient";

export declare interface Ingredient {
    code: number,
    name: string,
    moistureChange: number,
    retentionCode: number,
    // In grams
    amount: Measurement,
    nutrients: Nutrient[],
}

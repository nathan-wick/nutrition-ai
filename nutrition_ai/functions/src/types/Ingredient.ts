import {Measurement,} from "./Measurement";
import {Nutrient,} from "./Nutrient";

export declare interface Ingredient {
    code: number,
    name: string,
    moistureChange: string,
    retentionCode: string,
    // In grams
    amount: Measurement,
    nutrients: Nutrient[],
}

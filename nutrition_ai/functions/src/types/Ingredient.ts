import {Measurement,} from "./Measurement";
import {Nutrient,} from "./Nutrient";

export declare interface Ingredient {
    code: number,
    name: string,
    nutrients: Nutrient[],
    moistureChange: string,
    retentionCode: string,
    // In grams
    weight: Measurement,
}

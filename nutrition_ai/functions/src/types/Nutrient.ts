import {Measurement,} from "./Measurement";

export declare interface Nutrient {
    code: number,
    name: string,
    description: string,
    amount?: Measurement,
    defaultMeasurementUnit?: string,
}

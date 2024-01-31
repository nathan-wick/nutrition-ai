import {Part,} from "./Part";

export declare interface Ingredient {
    name: string,
    amount: string,
    parts?: Part[],
}

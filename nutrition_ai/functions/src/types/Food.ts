import {Ingredient,} from "./Ingredient";

export declare interface Food {
    code: number,
    name: string,
    description: string,
    category: string,
    ingredients: Ingredient[],
}

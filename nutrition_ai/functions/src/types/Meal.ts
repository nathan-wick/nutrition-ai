import { Ingredient } from "./Ingredient";

export declare interface Meal {
    name: string,
    photo: string,
    ingredients: Ingredient[],
    area?: string,
    category?: string,
    instructions?: string,
    youtube?: string,
}
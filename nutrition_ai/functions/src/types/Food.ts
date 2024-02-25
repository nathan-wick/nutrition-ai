import {Category,} from "./Category";
import {Ingredient,} from "./Ingredient";

export declare interface Food {
    code: string,
    name: string,
    description: string,
    category: Category,
    ingredients: Ingredient[],
}

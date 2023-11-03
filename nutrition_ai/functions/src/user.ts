export enum UserSex {
  xx,
  xy,
}

export enum HabitFrequency {
  none,
  light,
  moderate,
  very,
  extra
}

export enum Goal {
    loseWeight,
    maintainWeight,
    gainWeight,
    gainMuscle,
}

export class Measurement {
  constructor(public value: number, public unit: string) {}
}

export class Allergy {
  constructor(public name: string) {}
}

export class Ingredient {
  constructor(public name: string) {}
}

export class Habit {
  constructor(public name: string, public frequency: HabitFrequency) {}
}

export class GoalInfo {
  constructor(public goal: Goal) {}
}

export class User {
  constructor(
    public name: string,
    public email: string,
    public photo: string,
    public birthday?: Date | null,
    public sex?: UserSex | null,
    public height?: Measurement | null,
    public weight?: Measurement | null,
    public habits?: Habit[] | null,
    public goal?: GoalInfo | null,
    public allergies?: Allergy[] | null,
    public approvedIngredients?: Ingredient[] | null,
    public rejectedIngredients?: Ingredient[] | null
  ) {}

  age(): number | null {
    if (this.birthday) {
      const today = new Date();
      const birthDate = this.birthday;
      let age = today.getFullYear() - birthDate.getFullYear();
      const monthDiff = today.getMonth() - birthDate.getMonth();
      if (monthDiff < 0 || (monthDiff === 0 &&
          today.getDate() < birthDate.getDate())) {
        age--;
      }
      return age;
    } else {
      return null;
    }
  }
}

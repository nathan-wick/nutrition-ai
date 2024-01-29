enum MeasurementModelUnit {
    g = 'g',
    kcal = 'kcal',
    mg = 'mg',
    ug = 'ug',
    lbs = 'lbs',
    min = 'min',
    hr = 'hr',
    kg = 'kg',
    cm = 'cm',
    ft = 'ft',
  }

export declare interface Measurement {
    amount: number,
    unit: MeasurementModelUnit;
}
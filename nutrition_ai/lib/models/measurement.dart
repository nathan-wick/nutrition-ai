enum MeasurementUnit {
  g,
  kcal,
  mg,
  ug,
  lbs,
  min,
  hr,
}

class Measurement {
  final double amount;
  final MeasurementUnit unit;

  Measurement({
    required this.amount,
    required this.unit,
  });
}
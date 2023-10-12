enum MeasurementUnit {
  g,
  kg,
  kcal,
  mg,
  ug,
  lbs,
  min,
  hr,
  cm,
  ft
}

class Measurement {
  final double amount;
  final MeasurementUnit unit;

  Measurement({
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit.toString().split('.').last,
    };
  }

  Measurement toKg() {
    if (unit == MeasurementUnit.lbs) {
      return Measurement(
        amount: amount * 0.453592,
        unit: MeasurementUnit.kg,
      );
    } else {
      return this;
    }
  }

  Measurement toCm() {
    if (unit == MeasurementUnit.ft) {
      return Measurement(
        amount: amount * 30.48,
        unit: MeasurementUnit.cm,
      );
    } else {
      return this;
    }
  }

}
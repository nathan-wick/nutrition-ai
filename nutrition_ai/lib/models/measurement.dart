enum MeasurementModelUnit { g, kcal, mg, ug, lbs, min, hr, kg, cm, ft }

class MeasurementModel {
  final double amount;
  final MeasurementModelUnit unit;

  MeasurementModel({
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit.toString().split('.').last,
    };
  }

  MeasurementModel toKg() {
    if (unit == MeasurementModelUnit.lbs) {
      return MeasurementModel(
        amount: amount * 0.453592,
        unit: MeasurementModelUnit.kg,
      );
    } else {
      return this;
    }
  }

  MeasurementModel toCm() {
    if (unit == MeasurementModelUnit.ft) {
      return MeasurementModel(
        amount: amount * 30.48,
        unit: MeasurementModelUnit.cm,
      );
    } else {
      return this;
    }
  }
}

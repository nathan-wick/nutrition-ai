class MeasurementModel {
  final double amount;
  final String unit;

  MeasurementModel({
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit,
    };
  }
}

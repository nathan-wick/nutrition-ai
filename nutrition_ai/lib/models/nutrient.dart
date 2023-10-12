class Nutrient {
  final String name;
  final String code;

  Nutrient({
    required this.name,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'code' : code
    };
  }
}
class NutrientModel {
  final String name;
  final String code;

  NutrientModel({
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
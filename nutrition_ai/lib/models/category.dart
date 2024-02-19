class CategoryModel {
  final int code;
  final String name;

  CategoryModel({
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}

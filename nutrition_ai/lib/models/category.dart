import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      code: map['code'],
      name: map['name'],
    );
  }

  CategoryModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : code = snapshot['code'],
        name = snapshot['name'];
}

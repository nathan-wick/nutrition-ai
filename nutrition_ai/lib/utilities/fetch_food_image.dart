import 'package:firebase_storage/firebase_storage.dart';

Future<String?> fetchFoodImage(String code) async {
  return await FirebaseStorage.instance.ref().child('category_images/$code.jpeg').getDownloadURL();
}
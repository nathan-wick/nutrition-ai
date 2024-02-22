import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<String> fetchFoodImage(String code) async {
  String downloadUrl = "https://firebasestorage.googleapis.com/v0/b/nathan-wick-nutrition-ai.appspot.com/o/category_images%2Ftest.jpeg?alt=media&token=9564fe97-a118-41d8-bb01-bdbaff95e18e";
  try {
    downloadUrl = await FirebaseStorage.instance.ref().child('category_images/$code').getDownloadURL();
  } on FirebaseException catch (error) {
    if (kDebugMode) {
      print('Error while attempting to fetch category image $code');
    }
  }
  return downloadUrl;
}
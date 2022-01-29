// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/models/car.dart';

class AddProductController with ChangeNotifier {
  List<Car> productList = [];

  File imageUr;
  String imageUrl = '';
  final String url =
      "https://shopapp-23ab1-default-rtdb.firebaseio.com/product.json";

  void deletImage() {
    imageUrl = null;
  }

  Future getImage(ImageSource src) async {
    final PickedFile =
        await ImagePicker().getImage(source: src, imageQuality: 50);
    if (PickedFile != null) {
      imageUrl = PickedFile.path;
      imageUr = File(imageUrl);
      notifyListeners();
    } else {}
  }

  Future<void> add(
    String title,
    String description,
    double price,
  ) async {
    try {
      await Firebase.initializeApp();
      final ref = FirebaseStorage.instance
          .ref()
          .child('productphoto')
          .child(title + 'jpg');
      await ref.putFile(imageUr);
      final imurl = await ref.getDownloadURL();
      http.post(Uri.parse(url),
          body: jsonEncode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imurl
          }));
    } catch (error) {
      throw error;
    }
  }
}

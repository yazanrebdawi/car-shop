import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shopapp/models/car.dart';

class DetailesController with ChangeNotifier {
  List<Car> productList = [];
  Future<void> delete(String id) async {
    final String url =
        "https://shopapp-23ab1-default-rtdb.firebaseio.com/product/$id.json";

    final productIndex = productList.indexWhere((element) => element.id == id);
    var productItem = productList[productIndex];
    productList.removeAt(productIndex);
    notifyListeners();

    var response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      productList.insert(productIndex, productItem);
      notifyListeners();
    }
  }
}

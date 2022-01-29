import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shopapp/models/car.dart';

class HomePageController with ChangeNotifier {
  List<Car> productList = [];

  final String url =
      "https://shopapp-23ab1-default-rtdb.firebaseio.com/product.json";
  Future<void> fetch() async {
    try {
      var respons = await http.get(Uri.parse(url));
      final extractedData = jsonDecode(respons.body) as Map<String, dynamic>;
      extractedData.forEach((ProductId, ProductData) {
        var isexist = productList.firstWhere(
            (element) => element.id == ProductId,
            orElse: () => null);

        if (isexist == null) {
          productList.add(Car(
              id: ProductId,
              title: ProductData['title'],
              description: ProductData['description'],
              price: ProductData['price'],
              imageUrl: ProductData['imageUrl']));
        }
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void delete(String description) {
    productList.removeWhere((element) => element.description == description);
    notifyListeners();
  }
}

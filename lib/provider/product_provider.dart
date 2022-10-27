import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobieapp/product_model.dart';

import '../product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list = [];
  List<ProductModel> listCart = [];
  void getList() async {
    String urlAPI = 'https://fakestoreapi.com/products';
    var client = http.Client();
    var rs = await client.get(Uri.parse(urlAPI));
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString) as List;
    list = jsonObject.map((e) {
      return ProductModel(
        id: e['id'],
        title: e['title'],
        description: e['description'],
        price: e['price'],
        image: e['image'],
        category: e['category'],
      );
    }).toList();

    notifyListeners();
  }
 void getListCart(ProductModel e) async {
    //lay ds san pham tu FakeStoreAPI

    if (listCart.isEmpty) {
      listCart.add(e);
    } else if (listCart.every((element) => element.id == e.id)) {
      for (var element in listCart) {
        if (element.id == e.id) {
          element.soluong = (element.soluong! + 1);
        }
      }
    } else {
      listCart.add(e);
    }
    notifyListeners();
  }
}

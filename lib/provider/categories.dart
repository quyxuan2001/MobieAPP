import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobieapp/product_model.dart';

class Categaries extends ChangeNotifier {
  List<String> listCategaries = [];
  void getList() async {
    String urlAPI = 'https://fakestoreapi.com/products/categories';
    var client = http.Client();
    var rs = await client.get(Uri.parse(urlAPI));
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString) as List;
   listCategaries = jsonObject.map((e) {
      return e.toString();
    }).toList();

    notifyListeners();
  }
  
}

import 'package:flutter/material.dart';
import 'package:mobieapp/productlist_page.dart';
import 'package:mobieapp/provider/categories.dart';
import 'package:mobieapp/provider/product_provider.dart';
// import 'package:mobieapp/homepage.dart';
// import 'package:mobieapp/slider.dart';
// import 'package:mobieapp/gridview.dart';
// import 'package:mobieapp/login_page.dart';
// import 'package:mobieapp/singin_signup/login.dart';
import 'package:provider/provider.dart';
import 'package:mobieapp/cart.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => Categaries()),
      ],
      child: MaterialApp(
        home: ProductListPage(),
       
      ),
      
    ),
  );
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobieapp/Product_Details.dart';
//import 'package:mobieapp/main.dart';
import 'package:mobieapp/product_model.dart';
import 'package:mobieapp/provider/categories.dart';
import 'package:mobieapp/provider/product_provider.dart';

import 'package:mobieapp/cart.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

 bool showGrid = true;
 List<ProductModel> listPD = [];
  List<ProductModel> listCart = [];

  @override
  Widget build(BuildContext context) {
    
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
   

    var categories =Provider.of<Categaries>(context);
    categories.getList();
    
    if(listPD.isEmpty){
       setState(() {
        listPD = productProvider.list;
       
    });
    } 
   

  
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Center(child:Text("Home fashion")),
      ),
      body: SafeArea(
        child: Column(
          children: [
            buidSp(context, categories),
            buidSeach(context,productProvider),
            SizedBox(
              height: 10,
            ),
            buidButton(context), 
           
            showGrid ? buidGrid(context, productProvider) : buildList(context,productProvider),
           
            
          
          ],
        ),
      ),
    );
  }

  buidButton(BuildContext context){
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              showGrid = false;
            });
          },
          icon: Icon(Icons.list),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                showGrid = true;
              });
            },
            icon: Icon(Icons.grid_view))
      ],
    );
  }

  buidSeach(BuildContext context, ProductProvider productProvider){
   
    return Row(
      children: [
        Icon(Icons.search),
        SizedBox(
          height: 50,
          width: 120,
          child: TextField(
            decoration: InputDecoration(
              floatingLabelAlignment: FloatingLabelAlignment.start,
              hintText: "Search here",
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
           // controller: _searchKey,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        TextButton(
          onPressed: () {
           listPD.sort(
               (a, b) => a.price!.toDouble().compareTo(b.price!.toDouble()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Text(
            "Min",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        TextButton(
          onPressed: () {
           listPD.sort(
               (a, b) => b.price!.toDouble().compareTo(a.price!.toDouble()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Text(
            "Max",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Text(
            "Lọc",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      
         const SizedBox(
          width: 3,
        ),
        TextButton(
          onPressed: () =>{
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart(listCart: productProvider.listCart)),
            )
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          child: Icon(Icons.shopping_cart,
             color: Colors.white
          ),
        ),
      ],
    );
  }

  buidSp(BuildContext context, Categaries categories){
    return Container(
            height: 100,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...categories.listCategaries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Container(
                      
                        child: TextButton(
                          onPressed: (() {
                            print("${e}");
                          }) ,
                          child:  Text(e, style: TextStyle(color: Colors.white) ),
                         style: ButtonStyle(
                      
                         backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
                      ),
                      
                      ),
                    );
                  }).toList(),
              SizedBox(width: 15),
                ],
              ),
            ),
          );

  }

buildList(BuildContext context, ProductProvider productProvider) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
        ...listPD.map((e) {
              return Container(
                
                    margin: EdgeInsets.all(20),
                    
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black54)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        
                        children: [
                          Image.network(
                            e.image ?? "",
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(height: 10),
                          Text(e.title ?? "Title is null"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("giá: " + e.price.toString() ?? "0"),
                              Text(e.category ?? "category is null"),
                          
                            ],
                          ),
                         SizedBox(
                        height: 10
                          ),
                        TextButton(onPressed: ()=> {
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => ProductDetails(product: e)),),
                        },
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                        child: Text(
                              "xem chi tiết",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ), 
                         ),
                        ],
                      ),
                    ),
                  );
                }).toList()
        ],
      ),
    );
  }

  buidGrid(BuildContext context, ProductProvider productProvider) {
    return   Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ...listPD.map((e) {
                  return Container(
                    margin: const EdgeInsets.all(3.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black54)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          e.image ?? "",
                          height: 80,
                          width: 100,
                        ),
                        SizedBox(height: 10),
                        Text(e.title ?? "Title is null"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("giá: " + e.price.toString() ?? "0"),
                            Text(e.category ?? "category is null"),
                          ],
                        ),
                       SizedBox(
                        height: 10
                          ),
                        TextButton(onPressed: ()=> {
                          
                          
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) => ProductDetails(product: e)),),
                        },
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),
                        child: Text(
                              "Xem chi tiết",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ), 
                         ),
                      ],
                      
                    ),
                  );
                }).toList()
              ],
            ),
          );

  }
}
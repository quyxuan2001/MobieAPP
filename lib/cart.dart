import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobieapp/product_model.dart';
import 'package:mobieapp/productlist_page.dart';

import 'product_model.dart';

class Cart extends StatefulWidget {
   List<ProductModel> listCart;
   Cart({super.key, required this.listCart});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
   double total = 0;
    widget.listCart.forEach((element) {
      total += element.price!.toDouble() * element.soluong!.toDouble();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('Cart Store')),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 540,
            child: buildProductView(context, this.widget.listCart),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(fontSize: 30),
                ),
                Text('${total.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                
                  this.widget.listCart.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => (ProductListPage())),
                    ),
                  );
                },
                style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
                child: const Text(
                  "Check Out",
                  style: TextStyle(fontSize: 20, color: Colors.white)
                  ,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildProductView(BuildContext context, List<ProductModel> listCart) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ...listCart.map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 60, width: 60, child: Image.network(e.image ?? "")),
                SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          e.title ?? "Title is null",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          '${e.soluong}',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              e.soluong = (e.soluong! + 1);
                            });
                          },
                          icon: Icon(Icons.add)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                                if(e.soluong! <=1){
                                listCart.remove(e);
                              }else {
                                e.soluong = (e.soluong! -1);
                              }
                            });
                          },
                          icon: Icon(Icons.remove))
                    ],
                  ),
                ),
              ],
            );
          }).toList()
        ],
      ),
    );
  }
}
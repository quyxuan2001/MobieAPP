import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobieapp/cart.dart';
import 'package:mobieapp/product_model.dart';
import 'package:mobieapp/provider/product_provider.dart';



import 'package:provider/provider.dart';class ProductDetails extends StatelessWidget {
   final ProductModel product;

 ProductDetails({super.key, required this.product});
   List<ProductModel> listCart = [];
  


  @override
  Widget build(BuildContext context) {
     var productProvider = Provider.of<ProductProvider>(context);
       return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Center(child:Text("ProductDetails")),  
      ),
        body: Container(
        margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2.0)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.network(
                product.image ?? "",
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
              Text(
                product.title ?? "Title is null",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toString()}' ?? '00.00',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    product.category ?? '',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  productProvider.getListCart(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) =>
                          ( Cart(listCart: productProvider.listCart))),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
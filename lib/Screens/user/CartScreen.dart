import 'package:e_commerce_app/Provider/cartItem.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id="CartScreen";

  @override
  Widget build(BuildContext context) {
   List<Product>products= Provider.of<CartItem>(context).products;
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context,index){
          return Column(
            children: [
              Text(products[index].pName),
              Text(products[index].pQuantity.toString()),
            ],
          );
        },
        itemCount: products.length,
      ),
    );
  }
}

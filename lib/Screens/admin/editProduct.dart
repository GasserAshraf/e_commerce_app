import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';


class EditProduct extends StatefulWidget {
  static String id = "EditProduct";

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = [];
                for (var doc in snapshot.data.documents) {
                  var data = doc.data();
                  products.add(Product(
                      pPrice: data[kProductPrice],
                      pLocation: data[kProductLocation],
                      pDescription: data[kProductDescription],
                      pCategory: data[kProductCategory],
                      pName: data[kProductName]));
                }
                return ListView.builder(
                    itemBuilder: (context, index) =>
                        Text(products[index].pName),
                    itemCount: products.length);
              } else {
                return Center(
                  child: Text("Loading...."),
                );
              }
            }));
  }
}

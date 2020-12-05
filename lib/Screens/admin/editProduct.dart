import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String id = "EditProduct";

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Product>>(
            future: _store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemBuilder: (context, index) =>
                        Text(snapshot.data[index].pName),
                    itemCount: snapshot.data.length);
              } else {
                return Center(
                  child: Text("Loading...."),
                );
              }
            }));
  }
}

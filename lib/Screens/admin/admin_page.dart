import 'package:e_commerce_app/Screens/admin/addProduct.dart';
import 'package:e_commerce_app/Screens/admin/editProduct.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AdminPage extends StatelessWidget {
  static String id = "AdminPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text("Add Product")),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProduct.id);
            },
            child: Text("Edit Product"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("View Order"),
          )
        ],
      ),
    );
  }
}

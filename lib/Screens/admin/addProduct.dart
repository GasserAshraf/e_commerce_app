import 'package:e_commerce_app/Widgets/CutomTextfield.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  static String id = "Addproduct";
  String _name, _price, _description, _category, _imagelocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hint: "Product Name",
                onClick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Price",
                onClick: (value) {
                  _price = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Description",
                onClick: (value) {
                  _description = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Category",
                onClick: (value) {
                  _category = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "Product Location",
                onClick: (value) {
                  _imagelocation = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _store.addProduct(Product(
                          pName: _name,
                          pCategory: _category,
                          pDescription: _description,
                          pLocation: _imagelocation,
                          pPrice: _price));
                    }
                  },
                  child: Text("Add Product"))
            ],
          ),
        ),
      ),
    );
  }
}

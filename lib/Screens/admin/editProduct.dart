import 'package:e_commerce_app/Widgets/CutomTextfield.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _imagelocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Column(
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
                          _store.editProduct(
                              ({
                                kProductName: _name,
                                kProductCategory: _category,
                                kProductDescription: _description,
                                kProductLocation: _imagelocation,
                                kProductPrice: _price
                              }),
                              product.pId);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Edit Product"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

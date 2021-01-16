import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];

  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }
}

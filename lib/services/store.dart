import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/model/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
      kProductDescription: product.pDescription,
      kProductPrice: product.pPrice
    });
  }

  Future<List<Product>> loadProducts() async {
    var snapshot = await _firestore.collection(kProductsCollection).get();
    List<Product> products = [];
    for (var doc in snapshot.documents) {
      var data = doc.data();
      products.add(Product(
          pPrice: data[kProductPrice],
          pLocation: data[kProductLocation],
          pDescription: data[kProductDescription],
          pCategory: data[kProductCategory],
          pName: data[kProductName]));
    }
    return products;
  }
}

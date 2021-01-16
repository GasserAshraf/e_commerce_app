import 'package:flutter/cupertino.dart';

class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  String pId;
  int pQuantity;
  Color pColor;

  Product(
      {this.pQuantity,
      this.pName,
      this.pPrice,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pId,
      this.pColor
      });
}

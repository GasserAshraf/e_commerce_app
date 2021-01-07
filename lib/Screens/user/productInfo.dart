import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo";
  final Product product;

  const ProductInfo(this.product);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.pName,
          style: TextStyle(color: maincolor),
        ),
        iconTheme: IconThemeData(color: maincolor),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(
                Icons.shopping_cart,
                color: maincolor,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Image(
              image: AssetImage(widget.product.pLocation),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _groupValue = 1;
                },
                child: Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    //  disabledColor: Colors.blue
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.016,
                    width: MediaQuery.of(context).size.width * 0.035,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.red,
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (t) {
                            setState(() {
                              _groupValue = t;
                            });
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _groupValue = 2;
                },
                child: Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.016,
                    width: MediaQuery.of(context).size.width * 0.035,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.green,
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (t) {
                            setState(() {
                              _groupValue = t;
                            });
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _groupValue = 3;
                  });
                },
                child: Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.016,
                    width: MediaQuery.of(context).size.width * 0.035,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.yellow,
                          hoverColor: Colors.green,
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (t) {
                            setState(() {
                              _groupValue = t;
                            });
                          }),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

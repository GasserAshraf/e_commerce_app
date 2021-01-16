import 'package:e_commerce_app/Provider/cartItem.dart';
import 'package:e_commerce_app/Screens/user/CartScreen.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo";
  final Product product;

  const ProductInfo(this.product);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _groupValue = 1;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.pName,
          style: TextStyle(color: mainColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, CartScreen.id);
              },
              child: Icon(
                Icons.shopping_cart,
                color: mainColor,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image(
              image: AssetImage(widget.product.pLocation),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.product.pDescription,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("\$ ${widget.product.pPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipOval(
                          child: Material(
                            color: mainColor,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_quantity > 1) {
                                    _quantity--;
                                  }
                                });
                              },
                              child: SizedBox(
                                child: Icon(Icons.remove),
                                height: 28,
                                width: 28,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        ClipOval(
                          child: Material(
                            color: mainColor,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                              child: SizedBox(
                                child: Icon(Icons.add),
                                height: 28,
                                width: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Choose Color",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                customRadioButton(Colors.red, 1),
                SizedBox(
                  width: 20,
                ),
                customRadioButton(Colors.green, 2),
                SizedBox(
                  width: 20,
                ),
                customRadioButton(Colors.yellow, 3),
                SizedBox(
                  width: 20,
                ),
                customRadioButton(Colors.blue, 4),
              ],
            ),
          ),
          Expanded(
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height*0.1,
              child: Builder(
                builder: (context) => RaisedButton(
                  color: mainColor,
                  child: Text("ADD TO CART",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    product.pColor=chooseColor();
                    addToCart(product);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Added to Cart"),
                    ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customRadioButton(Color color, int value) {
    return GestureDetector(
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
          //  disabledColor: Colors.blue
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.width * 0.04,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Transform.scale(
            scale: 1.5,
            child: Radio(
                activeColor: color,
                value: value,
                groupValue: _groupValue,
                onChanged: (t) {
                  setState(() {
                    _groupValue = t;
                  });
                }),
          ),
        ),
      ),
    );
  }

  Color chooseColor(){
    if (_groupValue == 1) {
      return Colors.red;
    } else if (_groupValue == 2) {
      return Colors.green;
    } else if (_groupValue == 3) {
      return Colors.yellow;
    } else {
      return Colors.blue;
    }

  }

  void addToCart(Product product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    cartItem.addProduct(product);
  }
}

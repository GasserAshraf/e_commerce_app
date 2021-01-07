import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/user/productInfo.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  List<Product> _products = [];

  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
    print(_loggedUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: maincolor,
              currentIndex: _bottomBarIndex,
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("person")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("person")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("person")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text("person")),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: TabBar(
                indicatorColor: maincolor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    "jackets",
                    style: TextStyle(
                        color: _tabBarIndex == 0 ? Colors.black : unActiveColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null),
                  ),
                  Text("trousers",
                      style: TextStyle(
                          color:
                              _tabBarIndex == 1 ? Colors.black : unActiveColor,
                          fontSize: _tabBarIndex == 1 ? 16 : null)),
                  Text("t-shirts",
                      style: TextStyle(
                          color:
                              _tabBarIndex == 2 ? Colors.black : unActiveColor,
                          fontSize: _tabBarIndex == 2 ? 16 : null)),
                  Text("shoes",
                      style: TextStyle(
                          color:
                              _tabBarIndex == 3 ? Colors.black : unActiveColor,
                          fontSize: _tabBarIndex == 3 ? 16 : null)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                productView(kJackets),
                productView(kTrousers),
                productView(kTshirts),
                productView(kShoes)
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover".toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.shopping_cart)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget productView(String category) {
    final _store = Store();

    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data();
              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pLocation: data[kProductLocation],
                  pDescription: data[kProductDescription],
                  pCategory: data[kProductCategory],
                  pName: data[kProductName]));
            }
            _products = [...products];
            products.clear();
            products = getProductsByCategory(category);

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 1),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.decelerate);
                                    return ScaleTransition(
                                      scale: animation,
                                      alignment: Alignment.center,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return ProductInfo(products[index]);
                                  }));
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(products[index].pLocation)),
                            )),
                            Positioned(
                                bottom: 0,
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    color: Colors.grey[200],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("\$ ${products[index].pPrice}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                itemCount: products.length);
          } else {
            return Center(
              child: Text("Loading...."),
            );
          }
        });
  }

  List<Product> getProductsByCategory(String category) {
    List<Product> products = [];
    try {
      for (var product in _products) {
        if (product.pCategory == category) {
          products.add(product);
        }
      }
    } on Error catch (e) {
      print(e.toString());
    }
    return products;
  }
}

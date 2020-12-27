import 'package:e_commerce_app/Provider/adminMode.dart';
import 'package:e_commerce_app/Provider/modalhud.dart';
import 'package:e_commerce_app/Screens/admin/addProduct.dart';
import 'package:e_commerce_app/Screens/admin/admin_page.dart';
import 'package:e_commerce_app/Screens/admin/editProduct.dart';
import 'package:e_commerce_app/Screens/admin/manageProduct.dart';
import 'package:e_commerce_app/Screens/login_screen.dart';
import 'package:e_commerce_app/Screens/user/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/signup_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(create: (context) => ModalHud()),
        ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode())
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          EditProduct.id: (context) => EditProduct(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminPage.id: (context) => AdminPage(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct()
        },
      ),
    );
  }
}

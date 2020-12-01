import 'package:flutter/material.dart';
import 'package:e_commerce_app/Screens/login_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,

      routes: {
        LoginScreen.id:(context)=>LoginScreen()
      },
    );
  }
}

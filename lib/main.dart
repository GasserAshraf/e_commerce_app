import 'package:e_commerce_app/Provider/modalhud.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModalHud>(
      create: (context)=>ModalHud(),
      child: MaterialApp(
        initialRoute: LoginScreen.id,

        routes: {
          LoginScreen.id:(context)=>LoginScreen(),
          SignupScreen.id:(context)=>SignupScreen(),
        },
      ),
    );
  }
}

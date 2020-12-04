import 'package:e_commerce_app/Pages/admin_page.dart';
import 'package:e_commerce_app/Pages/home_page.dart';
import 'package:e_commerce_app/Provider/adminMode.dart';
import 'package:e_commerce_app/Provider/modalhud.dart';
import 'package:e_commerce_app/Screens/signup_screen.dart';
import 'package:e_commerce_app/Widgets/CutomTextfield.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final auth = Auth();
  String _email, _password;
  bool isAdmin = false;
  String adminPassword = "admin123";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: maincolor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(image: AssetImage("images/icons/shopping.png")),
                      Positioned(
                        bottom: 0.0,
                        child: Text(
                          "Just Buy It",
                          style:
                              TextStyle(fontFamily: 'Nerko One', fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              CustomTextField(
                hint: "Enter Your Email",
                icon: Icons.email,
                onClick: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                  hint: "Enter Your Password",
                  icon: Icons.lock,
                  onClick: (value) {
                    _password = value;
                  }),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
//                        final load =
//                            Provider.of<ModalHud>(context, listen: false);
//                        load.changeboolvalue(true);
//                        if (_globalKey.currentState.validate()) {
//                          _globalKey.currentState.save();
//                          try {
//                            final result = await auth.signIn(_email, _password);
//                            load.changeboolvalue(false);
//                          } catch (e) {
//                            load.changeboolvalue(false);
//                            Scaffold.of(context)
//                                .showSnackBar(SnackBar(content: e.message));
//                          }
//                        }
                        _validate(context);
                      },
                      color: Colors.black,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an acount ? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeIsAdmin(true);
                        },
                        child: Text(
                          "i'm an admin",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  Provider.of<AdminMode>(context, listen: false)
                                          .isAdmin
                                      ? maincolor
                                      : Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: Text("i'm a user",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : maincolor)),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeboolvalue(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      print(Provider.of<AdminMode>(context, listen: false).isAdmin.toString());
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            print("1");
            String s = await auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminPage.id);
            modalhud.changeboolvalue(false);
          } catch (e) {
            print("2");
            modalhud.changeboolvalue(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          print("3");
          modalhud.changeboolvalue(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Something Went Worng")));
          modalhud.changeboolvalue(false);
        }
      } else {
        try {
          print("4");
          String s = await auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
          modalhud.changeboolvalue(false);
        } catch (e) {
          print("5");
          modalhud.changeboolvalue(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
  }
}

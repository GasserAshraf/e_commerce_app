import 'package:e_commerce_app/Provider/modalhud.dart';
import 'package:e_commerce_app/Screens/login_screen.dart';
import 'package:e_commerce_app/Widgets/CutomTextfield.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static String id = "SignupScreen";
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
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
                hint: "Enter Your Name",
                icon: Icons.person,
                onClick: (value) {},
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                  hint: "Enter Your Email",
                  icon: Icons.email,
                  onClick: (value) {
                    _email = value;
                  }),
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
                        final modalhud =
                            Provider.of<ModalHud>(context, listen: false);
                        modalhud.changeboolvalue(true);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            String uid = await _auth.signUp(
                                _email.trim(), _password.trim());
                            modalhud.changeboolvalue(false);
                          } catch (e) {
                            modalhud.changeboolvalue(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(e.message),
                            ));
                          }
                        }
                        modalhud.changeboolvalue(false);
                      },
                      color: Colors.black,
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do have an acount ? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

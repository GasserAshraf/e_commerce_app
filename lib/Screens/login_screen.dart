import 'package:e_commerce_app/Screens/signup_screen.dart';
import 'package:e_commerce_app/Widgets/CutomTextfield.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final auth = Auth();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: maincolor,
      body: Form(
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
                        style: TextStyle(fontFamily: 'Nerko One', fontSize: 25),
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
                builder:(context)=> FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final result = await auth.signIn(_email, _password);
                        } catch (e) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: e.message));
                        }
                      }
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
            )
          ],
        ),
      ),
    );
  }
}

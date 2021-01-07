import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;

  String _errorMsg() {
    switch (hint) {
      case 'Enter Your Name':
        return "Name is Empty";
      case 'Enter Your Email':
        return "Email is Empty";
      case 'Enter Your Password':
        return "Password is Empty";
    }
    return "Enter Your Value";
  }

  CustomTextField(
      {@required this.onClick, @required this.hint, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: hint == "Enter Your Password" ? true : false,
        onSaved: onClick,
        validator: (value) {
          // ignore: missing_return
          if (value.isEmpty) {
            return _errorMsg();
          }
        },
        cursorColor: maincolor,

        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: maincolor,
          ),
          fillColor: txtfldclr,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  static String id = "HomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}

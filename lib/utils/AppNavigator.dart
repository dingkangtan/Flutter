import 'package:flutter/material.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => scene));
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static pushReplacement(BuildContext context, Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => route));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showAlertDialog(
      BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  static void showSnackBar(var scaffoldKey, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1, milliseconds: 500),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class mToast {
  void errorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFF44336),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void infoMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFF606060),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void successMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFF217A1B),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

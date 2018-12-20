import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static showToast( String msg) {
    Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        backgroundColor: Colors.black54,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }
}



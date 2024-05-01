import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showUnicalDialog({required String errorMessage}) {
  return Fluttertoast.showToast(
    msg: errorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



enum ToastStates{SUCCESS ,ERROR , WARNING}





void showToast(
{
  required String text,
  required ToastStates state,
}
    ) =>   Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);

// enum


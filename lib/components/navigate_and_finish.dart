
import 'package:flutter/material.dart';

void navigateAndFinish(
    context, 
    widget,
    ) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    ( Route<dynamic> route )=> false,//اقفلها
);
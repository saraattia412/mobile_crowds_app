import 'package:flutter/material.dart';
import 'package:flutter/services.dart';






ThemeData darkTheme= ThemeData(
  primarySwatch: Colors.deepOrange,

  scaffoldBackgroundColor:  Colors.transparent,

  appBarTheme:  const AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle:TextStyle(
      color: Colors.white,

      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,

    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(

          color: Colors.white
      )
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor:  Colors.transparent,
    elevation: 20
  )

);

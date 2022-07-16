

import 'package:flutter/material.dart';

Widget hDivider( BuildContext context) => Padding(
  padding: const EdgeInsets.all(16.0),
  child:   Center(

    child: Container(

      width:(MediaQuery.of(context).size.width)/3,

      height: 1,

      color: Colors.grey,

    ),

  ),
);

Widget wDivider( BuildContext context) => Padding(
  padding: const EdgeInsets.all(16.0),
  child:   Center(

    child: Container(

      width:2,

      height: 60,

      color: Colors.grey,

    ),

  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.white,
  ),
);



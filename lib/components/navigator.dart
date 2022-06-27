import 'package:flutter/material.dart';

navigateTo(context, widget) =>

    Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => widget,
        )
    );
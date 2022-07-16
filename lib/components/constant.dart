

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

String? uId;

File? pickedFile ;
String resultImage = '${Uri.file(pickedFile!.path).pathSegments.last} + _r';

//in data screen
var departmentController = SingleValueDropDownController();
var yearController = SingleValueDropDownController();
var subjectController = SingleValueDropDownController();



//in result screen
var dateController = TextEditingController();
var nameController = TextEditingController();

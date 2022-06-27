import 'dart:io';


import 'package:flutter/material.dart';

String? uId;

File? pickedFile;

var nameImage = Uri.file(pickedFile!.path).pathSegments.last;
var nameImageBack = nameImage + '_r';

//in result screen
var dateController = TextEditingController();
var nameController = TextEditingController();

//in home screen
var departmentController = TextEditingController();
var yearController = TextEditingController();
var subjectController = TextEditingController();



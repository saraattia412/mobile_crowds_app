// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType type,
  Function? onSubmit ,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefix,

  //part password
  bool isPassword =false,
  IconData? suffix,
  Function? suffixPressed,

  //on tap
  Function()? onTap,
  bool isClickable=true,
  bool? readOnly,


}) =>
    TextFormField(
      style: const TextStyle(
        color: Colors.white
      ),
      cursorColor: Colors.white,
      onFieldSubmitted: (value){
        onSubmit;
      },
      controller: controller,
      keyboardType: type,
      validator: validator,

      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color : Colors.white,
          fontSize: 13
        ),
        focusColor:Colors.white ,
        hoverColor: Colors.white,
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),



        labelStyle:const TextStyle(
          color: Colors.white,

        ) ,


        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),


        //password
        suffixIcon :suffix != null ?  IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.white,
          ),
        ) : null,

      ),

      //password
      obscureText:isPassword,

      //on tap
      onTap:() {
        onTap!();
      },

      enabled: isClickable,
//END ON TAP

    );

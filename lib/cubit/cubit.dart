





// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_crowds_app/components/constant.dart';
import 'package:mobile_crowds_app/cubit/states.dart';
import 'package:mobile_crowds_app/models/users_model.dart';

class CrowdCubit extends Cubit<CrowdStates>
{
  CrowdCubit() : super(InitialState());


  static CrowdCubit get(context) => BlocProvider.of(context);
  UsersModel? model;

  void getUserData(){
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          //print(value.data());
       model=UsersModel.fromJson(value.data());
          emit(GetUsersSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(GetUsersErrorState(error: error.toString()));

    });

  }

  Future getImage(ImageSource imageType) async {
    try {
      var photo = await ImagePicker().pickImage(source: imageType);

      if (photo == null) return;
      final image = File(photo.path);
      print(photo.path);
      pickedFile = image;
     emit(UploadImageState());
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  bool isBottomSheetShown = false;
  void changeBottomCheetState({
    required bool  isShow,
  }){
    isBottomSheetShown = isShow;
    emit(AppChangeBottomCheetState());
  }

Future selectDate(BuildContext context ) async {
    DateTime initialDate=DateTime.now();
    DateTime firstDate=DateTime(DateTime.now().year -10);
    DateTime lastDate=DateTime(DateTime.now().year +10);

    final date= await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
    ).then((value) {
      dateController.text =
          DateFormat.yMMMd().format(value!);
      print(DateFormat.yMMMd().format(value));
    });

    if(date != null){
      dateController = date as TextEditingController;
      emit(AppChangeDateScreen());
    }
}

void uploadImage(
  {
  required String? firstFolder,
   required String? secondFolder,
   required String? file,
}
    ){
    firebase_Storage
        .FirebaseStorage.instance
        .ref().child('$firstFolder/$secondFolder/$file/${Uri.file(pickedFile!.path).pathSegments.last}')
        .putFile(pickedFile!)
    .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error){
        print(error.toString());
      });
    })
    .catchError((error){
      print(error.toString());
    });
}





}
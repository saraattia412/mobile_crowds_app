





// ignore_for_file: avoid_print


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_crowds_app/components/constant.dart';
import 'package:mobile_crowds_app/cubit/states.dart';
import 'package:mobile_crowds_app/models/users_model.dart';
import 'package:path_provider/path_provider.dart';

import '../models/save_data_model.dart';

class CrowdCubit extends Cubit<CrowdStates> {
  CrowdCubit() : super(InitialState());


  static CrowdCubit get(context) => BlocProvider.of(context);
  UsersModel? model;

  void getUserData() {
    emit(GetUsersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      //print(value.data());
      model = UsersModel.fromJson(value.data());
      emit(GetUsersSuccessState());
    })
        .catchError((error) {
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

  void changeBottomChetState({
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;
    emit(AppChangeBottomCheetState());
  }

  Future selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(DateTime
        .now()
        .year - 10);
    DateTime lastDate = DateTime(DateTime
        .now()
        .year + 10);

    final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
    ).then((value) {
      dateController.text =
          DateFormat.yMMMd().format(value!);
      print(DateFormat.yMMMd().format(value));
    });

    if (date != null) {
      dateController = date as TextEditingController;
      emit(AppChangeDateScreen());
    }
  }

  Future<void> uploadImage({
    required String? year,
    required String? department,
    required String? subject,

  }) async {
    firebase_storage
        .FirebaseStorage.instance
        .ref().child('$year/$department/$subject/${Uri.file(pickedFile!.path).pathSegments.last}')
        .putFile(pickedFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error) {
        print(error.toString());
      });
    })
        .catchError((error) {
      print(error.toString());
    });
  }


  void saveData({
    required String name,
    required String date,
    required String? year,
    required String? department,
    required String? subject,

  }) {
    final docData=FirebaseFirestore.instance.collection('save_data').doc(uId).collection('data').doc();

    SaveDataModel model = SaveDataModel(
      date: date,
      name: name,
      id: docData.id,
      path: '$year/$department/$subject',
    );


        docData.set(model.toMap())
        .then((value) {
      emit(SuccessSaveDataState());
    })
        .catchError((error) {
      emit(ErrorSaveDataState(error.toString()));
    });
  }

Stream<List<SaveDataModel>> getSaveData(){
    return FirebaseFirestore.instance.collection('save_data').doc(uId).collection('data').
    orderBy('date' , descending: true)
        .snapshots().map((snapshot) => snapshot.docs.map((doc) => SaveDataModel.fromJson(doc.data())).toList());
}


  Future getFiles(
  {
    required String? year,
    required String? department,
    required String? subject,
}
      ) async{
    final pdfPath = '$year/$department/$subject/${Uri.file(pickedFile!.path).pathSegments.last}.replaceAll(".jpg", "_p.pdf")}';
    final resultPath = '$year/$department/$subject/${Uri.file(pickedFile!.path).pathSegments.last}.replaceAll(".jpg", "_r.jpg")}';
    final countPath = '$year/$department/$subject/${Uri.file(pickedFile!.path).pathSegments.last}.replaceAll(".jpg", "_c.txt")}';
    final path = '$year/$department/$subject/';
    
    FirebaseStorage.instance.ref().child('$pdfPath/ts11');

      }





}
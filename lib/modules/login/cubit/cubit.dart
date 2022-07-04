// ignore_for_file: avoid_print





import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_crowds_app/modules/login/cubit/states.dart';

class LogInCubit extends Cubit<LogInStates>{
  LogInCubit() : super(InitialLogInStates());

  static LogInCubit get(context) => BlocProvider.of(context);



  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword ?Icons.visibility_off_outlined: Icons.visibility_outlined ;
    emit(ChangePasswordVisibilityLogInState());

  }


  void UserLogIn({
    required String email,
    required String password,

  })
  {
    emit(LoadingLogInState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(SuccessLogInState(uId: value.user!.uid));
    }).catchError((error){
      emit(ErrorLogInState(error.toString()));
    });







  }




Future resetPassword(
  {
    required String email
}
    )async{
     FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInWithGoogle() async {
    emit(GoogleLoadingLogInState());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    User? _user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    //add to fireStore
    if(_user != null){
      final  QuerySnapshot resultQuery = await FirebaseFirestore.instance
          .collection("users")
          .where(
        'uId',
        isEqualTo: _user.uid,
      ).get();
      emit(GoogleLoginSuccessState(_user.uid));
      final List<DocumentSnapshot> _documentSnapshots = resultQuery.docs;
      if(_documentSnapshots.isEmpty){
        FirebaseFirestore.instance.collection("users").doc(_user.uid).set(
            {
              'uId': _user.uid,
              'email': _user.email,
              'phone': _user.phoneNumber,
              'name' : _user.displayName,
            }).then((value){
          print('user data saved');
        }).catchError((error){
          print(error);
          emit(GoogleLoginErrorState(error.toString()));
        });
      }
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
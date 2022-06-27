// ignore_for_file: avoid_print





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_crowds_app/models/users_model.dart';
import 'states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(InitialSignUpStates());

  static SignUpCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangePasswordVisibilitySignUpState());
  }


  void userSignUp({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(LoadingSignUpStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      userCreate(
        name: name,
        uId: value.user!.uid,
        email: email,
        phone: phone,
      );
    }).catchError((error) {
      emit(ErrorSignUpStates(error.toString()));
    });
  }


  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,

  }) {
    UsersModel model = UsersModel(
      email: email,
      name: name,
      uId: uId,
      phone: phone,
      isEmailVerified: false,

    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccessCreateUserSignUpState());
    })
        .catchError((error) {
      emit(CreateUserErrorSignUpState(error.toString()));
    });
  }


  Future<UserCredential> signInWithGoogle() async {
    emit(GoogleLoadingSignUpStates());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
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
      emit(GoogleSignUpSuccessState(_user.uid));
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
          emit(GoogleSignUpErrorState(error.toString()));
        });
      }
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


}


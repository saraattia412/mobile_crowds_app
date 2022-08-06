// ignore_for_file: avoid_print, must_be_immutable

import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_crowds_app/components/navigate_and_finish.dart';
import 'package:mobile_crowds_app/modules/home/home_screen.dart';

import '../../components/default_button.dart';
import '../../components/form_field.dart';
import '../../components/line.dart';
import '../../components/toast_package.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var userController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (BuildContext context, state) {
          if(state is GoogleSignUpErrorState){
            showToast(text: state.error.toString().replaceRange(0, 14, '').split(']')[1], state: ToastStates.error);
          }
          if(state is GoogleSignUpSuccessState){
            showToast(text: 'Sign up done'.toString(), state: ToastStates.success);
          }
          if (state is ErrorSignUpStates ) {
            showToast(text: state.error.toString().replaceRange(0, 14, '').split(']')[1], state: ToastStates.error);
          }
          if (state is SuccessCreateUserSignUpState ) {
            showToast(text: 'Sign up done'.toString(), state: ToastStates.success);
          }
          if (state is SuccessCreateUserSignUpState || state is GoogleSignUpSuccessState) {
            navigateAndFinish(context,  HomeScreen());
          }
        },
        builder: (BuildContext context, Object? state) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/p1.jpeg'),
                      fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      ' Mobile Crowds',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white

                      ),
                    ),

                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                onTap: (){
                                  print('done');
                                },
                                controller: userController,
                                type: TextInputType.name,
                                label: 'Username',
                                prefix: Icons.account_circle_outlined,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "username  must be not empty";
                                  }
                                  return null;
                                },
                                onSubmit: (value) {
                                  TextInputAction.done;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                onTap: (){
                                  print('done');
                                },
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'Email Address',
                                prefix: Icons.attach_email_outlined,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "please enter your email address";
                                  }
                                  return null;
                                },
                                onSubmit: (value) {
                                  TextInputAction.done;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                onTap: (){
                                  print('done');
                                },
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                prefix: Icons.lock_outlined,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Password Is Too Short";
                                  }
                                  return null;
                                },
                                onSubmit: (value) {
                                  TextInputAction.done;
                                },
                                isPassword: SignUpCubit.get(context).isPassword,
                                suffix: SignUpCubit.get(context).suffix,
                                suffixPressed: () {
                                  //الدوسه
                                  SignUpCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                onTap: (){
                                  print('done');
                                },
                                controller: phoneController,
                                type: TextInputType.phone,
                                label: 'Phone',
                                prefix: Icons.phone_android_outlined,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "please enter your phone";
                                  }
                                  return null;
                                },
                                onSubmit: (value) {
                                  TextInputAction.done;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoadingSignUpStates,
                                builder: (BuildContext context) =>
                                    defaultButton(
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          SignUpCubit.get(context).userSignUp(
                                              name: userController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text);
                                        }
                                      },
                                      text: 'sign up',
                                      isUpperCase: true,
                                    ),
                                fallback: (context) => const Center(child: CircularProgressIndicator()),
                              ),
                              const SizedBox(height: 30,),
                              Row(
                                children: [
                                  Expanded(child: hDivider(context)),
                                  const Center(
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Expanded(child: hDivider(context)),

                                ],
                              ),


                              ConditionalBuilder(
                                  condition: state is ! GoogleLoadingSignUpStates,
                                  builder:(BuildContext context) => Center(
                                    child: TextButton(
                                      onPressed: () {
                                        SignUpCubit.get(context).signInWithGoogle();
                                      },
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white
                                              ),
                                              top: BorderSide(
                                                  color: Colors.white
                                              ),
                                              left: BorderSide(
                                                  color: Colors.white
                                              ),
                                              right: BorderSide(
                                                  color: Colors.white
                                              ),

                                            )
                                        ),

                                        child: Center(
                                          child: Row(
                                            children: const [
                                              SizedBox(width: 20,),

                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Image(image: NetworkImage(
                                                  'https://img.icons8.com/color/344/google-logo.png',
                                                ),
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              Text(
                                                'Sign In With Google',
                                                style: TextStyle(

                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),),
                                  ),
                                  fallback:(context) => const Center(child: CircularProgressIndicator()), )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}

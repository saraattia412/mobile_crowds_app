// ignore_for_file: avoid_print, must_be_immutable

import 'dart:ui';


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_crowds_app/components/navigate_and_finish.dart';
import 'package:mobile_crowds_app/components/toast_package.dart';
import 'package:mobile_crowds_app/modules/home/home_screen.dart';
import 'package:mobile_crowds_app/network/local/cache_helper.dart';

import '../../components/constant.dart';
import '../../components/default_button.dart';
import '../../components/form_field.dart';
import '../../components/line.dart';
import '../../components/navigator.dart';
import '../signup/signup.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    var passController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
        listener: (BuildContext context, state) {
          if (state is GoogleLoginErrorState ) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is ErrorLogInState ) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SuccessLogInState ) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context,  HomeScreen());
            });
          }
          if(state is GoogleLoginSuccessState) {
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
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Scaffold(

                appBar: AppBar(
                  title: Row(
                    children:  [
                      Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),),
                          )),
                      const Text(
                        ' Mobile Crowds',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white

                        ),
                      ),
                    ],
                  ),


                ),

                body:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [

                            const Text(
                              'LogIn',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),

                            const SizedBox(height: 40,),

                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.attach_email_outlined,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "please enter your email ";
                                }
                                return null;
                              },
                              onSubmit: (value) {
                                TextInputAction.done;
                              },
                              onTap: (){
                                print('done');
                              },
                            ),
                            const SizedBox(height: 30,),

                            defaultFormField(
                              onTap: (){
                                print('done');
                              },
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              label: 'Password',
                              prefix: Icons.lock_outlined,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "password  must be not empty";
                                }
                                return null;
                              },
                              onSubmit: (value) {
                                TextInputAction.done;
                              },
                              isPassword: LogInCubit
                                  .get(context)
                                  .isPassword,
                              suffix: LogInCubit
                                  .get(context)
                                  .suffix,
                              suffixPressed: () { //الدوسه
                                LogInCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),


                            const SizedBox(height: 30,),

                            ConditionalBuilder(
                              condition: state is! LoadingLogInState,
                              builder: (BuildContext context) =>
                                  defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LogInCubit.get(context).UserLogIn(
                                          email: emailController.text,
                                          password: passController.text,
                                        );
                                      }
                                    },
                                    text: 'login',
                                    isUpperCase: true,
                                  ),
                              fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                            ),
                            TextButton(
                                onPressed: () {
                                  LogInCubit.get(context).resetPassword(email: emailController.text);
                                },
                                child: const Text(
                                  'Forget password ?!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                            Row(
                              children: [
                                hDivider(context),
                                const Center(
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                        color: Colors.white,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                                hDivider(context),

                              ],
                            ),
                            const SizedBox(height: 20,),
                            ConditionalBuilder(
                              condition: state is! GoogleLoadingLogInState,
                              builder:(BuildContext context) => Center(
                                child: TextButton(
                                  onPressed: () {
                                    LogInCubit.get(context).signInWithGoogle();
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
                              fallback:(context) => const Center(child: CircularProgressIndicator()), ),
                            const SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      color: Colors.white

                                  ),

                                ),
                                TextButton(onPressed: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                    child: const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),

                                const SizedBox(height: 20,),


                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),


              ),
            ],
          );
        },

      ),
    );
  }


}

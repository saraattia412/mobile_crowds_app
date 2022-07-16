// ignore_for_file: avoid_print, must_be_immutable

import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_crowds_app/components/navigate_and_finish.dart';
import 'package:mobile_crowds_app/cubit/cubit.dart';
import 'package:mobile_crowds_app/cubit/states.dart';
import 'package:mobile_crowds_app/modules/data/data_screen.dart';
import 'package:mobile_crowds_app/modules/save_data/saveDate_screen.dart';
import 'package:mobile_crowds_app/modules/starting/startScreen.dart';

import '../../components/constant.dart';
import '../../components/navigator.dart';
import '../../components/toast_package.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  User? user;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrowdCubit, CrowdStates>(
      listener: (BuildContext context, state) {
        if (pickedFile != null) {
          navigateTo(context, DataScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        var size = MediaQuery.of(context).size;
        var width = size.width;

        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/p1.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text(
                  ' Select',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                  ),
                ],
              ),
              endDrawer: Drawer(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                    ),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      size: 20,
                    ),
                    title: const Text(
                      'select now',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      navigateAndFinish(context, HomeScreen());
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.save,
                      size: 20,
                    ),
                    title: const Text(
                      'Saving Data',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      navigateAndFinish(context,  SaveData());
                    },
                  ),
                  Stack(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.follow_the_signs_outlined,
                          size: 20,
                        ),
                        title: const Text(
                          'SIGN OUT',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          navigateAndFinish(context, const StartScreen());
                        },
                      ),
                    ],
                  ),
                ],
              )),
              bottomSheet: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  child: Container(
                    height: 300,
                    color: Colors.deepOrange.withOpacity(.75),
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: HexColor('082032'),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  CrowdCubit.get(context)
                                      .getImage(ImageSource.gallery);
                                },
                                icon: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: HexColor('082032'),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  CrowdCubit.get(context)
                                      .getImage(ImageSource.camera);
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body:ConditionalBuilder(
                  condition: CrowdCubit.get(context).model != null,
                  builder: (context) {
                    return Column(

                      children: [
                    if(!FirebaseAuth.instance.currentUser!.emailVerified)
                        Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: width,
                          height: 40,
                          color: Colors.black.withOpacity(.8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10,),
                              const Text(
                                'please Verify your email',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              const SizedBox(width: 30,),
                              TextButton(
                                  onPressed: () async {
                                    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                                      showToast(text: 'check your mail', state: ToastStates.success);
                                    }).catchError((error){});
                                  },
                                  child: const Text(
                                    'send',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 25
                                    ),
                                  )
                              )
                            ],),
                        ),
                      )

                      ],
                    );


                  },
                  fallback: (context) => const Center(child: CircularProgressIndicator())
              ),
            )
          ],
        );
      },
    );
  }
}

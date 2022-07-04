// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/modules/confirm/confirm_screen.dart';

import '../../components/constant.dart';
import '../../components/default_button.dart';
import '../../components/form_field.dart';
import '../../components/navigate_and_finish.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../home/home_screen.dart';
import '../save_data/savedate_screen.dart';
import '../starting/startscreen.dart';

class DataScreen extends StatelessWidget {
   DataScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CrowdCubit, CrowdStates>(
      listener: (BuildContext context, state) {
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
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (BuildContext context) => IconButton(
                    icon: const Icon(Icons.chevron_left,
                      color: Colors.white,
                    ),
                    onPressed: () => navigateAndFinish(context, HomeScreen()),
                  ),

                ),
                title:Row(
                  children:  [
                    Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),),
                        )),
                    const Text(
                      ' Data',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white

                      ),
                    ),
                  ],
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
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: HexColor('082032'),
                        ),
                        child: const Text(
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
              bottomSheet:
              SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  child: Container(
                    color: Colors.deepOrange.withOpacity(.75),
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                            controller: yearController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Year must be not empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print(yearController);
                            },
                            label: 'Year',
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: departmentController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Department must be not empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print(departmentController);
                            },
                            label: 'Department',
                            prefix: Icons.drive_file_rename_outline,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          defaultFormField(
                            controller: subjectController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Subject must be not empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print(subjectController);
                            },
                            label: 'Subject',
                            prefix: Icons.drive_file_rename_outline,

                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: true,
                            builder: (BuildContext context) =>
                                defaultButton(
                                  function: () {
                                    if(formKey.currentState!.validate()){
                                      CrowdCubit.get(context).uploadImage(
                                          year: yearController.text,
                                          department: departmentController.text,
                                          subject: subjectController.text).then((value) {
                                        print('done upload');
                                      }).then((value) {
                                        navigateAndFinish(context, const ConfirmScreen());

                                      });

                                    }
                                  },
                                  text: 'save',
                                  isUpperCase: true,
                                  background: HexColor('082032'),
                                ),
                            fallback: (BuildContext context) =>
                            const Center(
                                child:
                                CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                            function: () {
                              Get.back();
                            },
                            text: 'cancel',
                            background: HexColor('082032'),
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

    );
  }
}

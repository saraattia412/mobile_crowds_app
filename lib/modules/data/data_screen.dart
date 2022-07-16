// ignore_for_file: avoid_print, must_be_immutable, unnecessary_null_comparison

import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/modules/confirm/confirm_screen.dart';

import '../../components/constant.dart';
import '../../components/default_button.dart';
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
                title:const Text(
                  ' Data',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white

                  ),
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
                          //year
                           DropDownTextField(

                             singleController: yearController,
                            dropDownItemCount: 4,
                             clearOption: false,
                             enableSearch: false,
                             validator: (String? value) {
                               if (yearController.dropDownValue?.value.toString() == null) {
                                 return "Year Is Required";
                               } else {
                                 return null;
                               }
                             },
                             isEnabled: true,

                            textFieldDecoration: InputDecoration(
                              prefixIcon: const Icon(
                                  Icons.drive_file_rename_outline,
                                color: Colors.deepOrange,
                              ),
                              label: const Text(
                                'year',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                                labelStyle:const TextStyle(
                                  color: Colors.deepOrange,
                                ) ,
                              fillColor: Colors.white,
                                filled: true,
                                errorStyle : const TextStyle(
                                    color: Colors.white
                                ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color:  Colors.white,
                                  width: 2.0,
                                )
                              )
                            ),

                            dropDownList: const [
                              DropDownValueModel(name: '1st-year', value: "1st-year"),
                              DropDownValueModel(name: '2nd-year', value: "2nd-year"),
                              DropDownValueModel(name: '3rd-year', value: "3rd-year"),
                              DropDownValueModel(name: '4th-year', value: "4th-year"),
                          ],
                             onChanged: (val) {
                               print(yearController.dropDownValue!.value.toString());
                             },
                           ),
                          const SizedBox(height: 20,),
                          DropDownTextField(
                            singleController: departmentController,
                            dropDownItemCount: 3,
                            clearOption: false,
                            enableSearch: false,
                            validator: (String? value) {
                              if (departmentController.dropDownValue?.value.toString() == null) {
                                return "Department Is Required";
                              } else {
                                return null;
                              }
                            },
                            isEnabled: true,

                            textFieldDecoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Colors.deepOrange,
                                ),
                                label: const Text(
                                  'Department',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                                labelStyle:const TextStyle(
                                  color: Colors.deepOrange,
                                ) ,
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle : const TextStyle(
                                    color: Colors.white
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                      color:  Colors.white,
                                      width: 2.0,
                                    )
                                )
                            ),

                            dropDownList: const [
                              DropDownValueModel(name: 'cs', value: "cs"),
                              DropDownValueModel(name: 'it', value: "it"),
                              DropDownValueModel(name: 'is', value: "is"),
                            ],
                            onChanged: (val) {
                              print(departmentController.dropDownValue!.value.toString());
                            },
                          ),
                          const SizedBox(height: 20,),
                          SingleChildScrollView(
                            child: DropDownTextField(
                              singleController: subjectController,
                              dropDownItemCount: 10,
                              clearOption: false,
                              enableSearch: false,
                              validator: (String? value) {
                                if (subjectController.dropDownValue?.value.toString() == null) {
                                  return "subject Is Required";
                                } else {
                                  return null;
                                }
                              },
                              isEnabled: true,

                              textFieldDecoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Colors.deepOrange,
                                  ),
                                  label: const Text(
                                    'Subject',
                                    style: TextStyle(
                                        fontSize: 15
                                    ),
                                  ),
                                  labelStyle:const TextStyle(
                                    color: Colors.deepOrange,
                                  ) ,
                                  fillColor: Colors.white,
                                  filled: true,
                                  errorStyle : const TextStyle(
                                      color: Colors.white
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(
                                        color:  Colors.white,
                                        width: 2.0,
                                      )
                                  )
                              ),
                              dropDownList: const [
                                DropDownValueModel(name: 'Deep Leaning', value: "deep leaning"),
                                DropDownValueModel(name: 'Parallel Processing', value: "parallel processing"),
                                DropDownValueModel(name: 'Algorithm', value: "Algorithm"),
                                DropDownValueModel(name: 'Compiler', value: "Compiler"),
                                DropDownValueModel(name: 'Data Structure', value: "Data Structure"),
                                DropDownValueModel(name: 'Machine Learning', value: "Machine Learning"),
                                DropDownValueModel(name: 'Formal Language', value: "Formal Language"),
                                DropDownValueModel(name: 'Expert System', value: "Expert System"),
                                DropDownValueModel(name: 'Final', value: "Final"),
                                DropDownValueModel(name: 'Mid Term', value: "Mid Term"),
                              ],
                              onChanged: (val) {
                                print(subjectController.dropDownValue!.value.toString());
                              },
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ConditionalBuilder(
                            condition: true,
                            builder: (BuildContext context) =>
                                defaultButton(
                                  function: () {
                                    if(formKey.currentState!.validate()){
                                      CrowdCubit.get(context).uploadImage(
                                          year: yearController.dropDownValue!.value.toString(),
                                          department: departmentController.dropDownValue!.value.toString(),
                                          subject: subjectController.dropDownValue!.value.toString()).then((value) {
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

// ignore_for_file: avoid_print, must_be_immutable, sized_box_for_whitespace



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/components/default_button.dart';
import 'package:mobile_crowds_app/components/navigate_and_finish.dart';
import 'package:mobile_crowds_app/components/navigator.dart';
import 'package:mobile_crowds_app/cubit/cubit.dart';
import 'package:mobile_crowds_app/cubit/states.dart';
import 'package:mobile_crowds_app/modules/pdf/pdf_screen.dart';
import '../../components/constant.dart';
import '../../components/form_field.dart';
import '../home/home_screen.dart';
import '../save_data/saveDate_screen.dart';
import '../starting/startScreen.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    bool image = false;


    return BlocConsumer<CrowdCubit, CrowdStates>(
      listener: (BuildContext context, state) {
        if(state is GetUrlPdfResultState){
          image=true;
        }


      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: HexColor('082032'),
          appBar: AppBar(
            title:const Text(
              ' Result',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                  navigateAndFinish(context, SaveData());
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width,
                    height: height/2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: width,
                        height: height/2,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: image == true
                          ?
                        Image.network(
                          CrowdCubit.get(context).imageUrl
                        )
                      :
                        const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(''),
                const SizedBox(
                  height: 20,
                ),
                 image
                     ?
                 InkWell(
                   onTap:(){
                     navigateTo(context, PdfScreen(url : CrowdCubit.get(context).pdfUrl,));
                   } ,
                  child: Container(
                    height: 30,
                    width: 200,
                    color: Colors.white,
                    child: const Center(
                        child: Text(
                            'DPF result',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20
                          ),
                        )),
                  ),

                )
                :
                 const Center(child: CircularProgressIndicator()),
                const SizedBox(
                  height: 20,
                ),

                defaultButton(
                    function: () {
                      if (CrowdCubit.get(context).isBottomSheetShown) {
                      } else {
                        Get.bottomSheet(
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
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            'Saving',
                                            style: TextStyle(
                                                color: HexColor('082032'),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      defaultFormField(
                                        controller: nameController,
                                        type: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'name must be not empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          print(nameController);
                                        },
                                        label: 'Name',
                                        prefix: Icons.drive_file_rename_outline,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      defaultFormField(
                                        controller: dateController,
                                        type: TextInputType.none,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Date must be not empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          CrowdCubit.get(context)
                                              .selectDate(context);
                                        },
                                        label: 'Date',
                                        prefix: Icons.date_range_outlined,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ConditionalBuilder(
                                        condition: true,
                                        builder: (BuildContext context) =>
                                            defaultButton(
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              CrowdCubit.get(context).saveData(
                                                  name: nameController.text,
                                                  date: dateController.text,
                                                  year: yearController.dropDownValue!.value.toString(),
                                                  department:
                                                      departmentController.dropDownValue!.value.toString(),
                                                  subject:
                                                      subjectController.dropDownValue!.value.toString());
                                              navigateAndFinish(
                                                  context, SaveData());
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
                        ).then((value) {
                          CrowdCubit.get(context)
                              .changeBottomChetState(isShow: true);
                        });
                      }
                    },
                    text: 'save'),
              ],
            ),
          ),
        );
      },
    );
  }
}

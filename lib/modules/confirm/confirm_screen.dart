

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/components/default_button.dart';

import '../../components/constant.dart';
import '../../components/navigate_and_finish.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../home/home_screen.dart';
import '../result/result_screen.dart';
import '../save_data/savedate_screen.dart';
import '../starting/startscreen.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var width = size.width;

    return BlocConsumer<CrowdCubit, CrowdStates>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: HexColor('082032'),

          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.backspace_outlined,
                  color: Colors.red,
                ),
                onPressed: () => navigateAndFinish(context, HomeScreen()),
              ),

            ),
            title: const Text(
              ' Confirm',
              style: TextStyle(
                  fontSize: 20,
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
                      color:Colors.deepOrange,
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width,
                    height: 500,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 3),
                      borderRadius:  BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(25),
                      child: Container(
                        width: width,
                        height: 500,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:  BorderRadius.circular(25),
                        ),
                        child: pickedFile  != null
                            ? Image.file(
                         pickedFile!  ,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/p1.jpeg',
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),
                defaultButton(function: (){
                  navigateAndFinish(context,  ResultScreen());
                }, text: 'CONFIRM')

              ],

            ),
          ),
        );
      },

    );
  }
}

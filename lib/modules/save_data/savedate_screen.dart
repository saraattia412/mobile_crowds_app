import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/cubit/cubit.dart';
import 'package:mobile_crowds_app/cubit/states.dart';

import '../../components/navigate_and_finish.dart';
import '../home/home_screen.dart';
import '../starting/startscreen.dart';


class SaveData extends StatelessWidget {
  const SaveData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrowdCubit,CrowdStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: HexColor('082032'),

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
                  ' Save Data',
                  style: TextStyle(
                      fontSize: 20,
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
                      navigateAndFinish(context, const SaveData());
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
          body: Column(
            children: [
              Row(
                children: [

                ],
              )
            ],
          ),

        );
      },

    );
  }
}

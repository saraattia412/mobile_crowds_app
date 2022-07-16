// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_crowds_app/components/line.dart';
import 'package:mobile_crowds_app/cubit/cubit.dart';
import 'package:mobile_crowds_app/cubit/states.dart';

import '../../components/navigate_and_finish.dart';
import '../../models/save_data_model.dart';
import '../home/home_screen.dart';
import '../starting/startScreen.dart';

class SaveData extends StatelessWidget {
   SaveData({Key? key}) : super(key: key);
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrowdCubit, CrowdStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: HexColor('082032'),
            appBar: AppBar(
              title: const Text(
                ' Save Data',
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

            body: StreamBuilder<List<SaveDataModel>>(
                stream: CrowdCubit.get(context).getSaveData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text(
                          'we got error',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                     final data = snapshot.data;
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context,index) =>
                          design(context,data[index]),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        });
  }
}



Widget design(BuildContext context,SaveDataModel model) => Padding(
  padding: const EdgeInsets.all(20.0),
  child:Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [

      Row(
        children: [
          Text(
            model.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(width: 30,),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              model.date,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20,),
      Text(
        model.path,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 20,),
      myDivider(),
    ],
  ),
);

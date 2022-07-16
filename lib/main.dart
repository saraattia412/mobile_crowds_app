

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_crowds_app/bloc_observer.dart';
import 'package:mobile_crowds_app/cubit/cubit.dart';
import 'package:mobile_crowds_app/modules/home/home_screen.dart';
import 'package:mobile_crowds_app/styles/theme.dart';

import 'components/constant.dart';
import 'modules/starting/startScreen.dart';
import 'network/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //load firebase
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseAppCheck.instance.activate();
    await CacheHelper.init();
    uId = CacheHelper.getData(key: 'uId');
    late Widget widget;


    if (uId != null) {
      widget = HomeScreen();
    } else {
      widget = const StartScreen();
    }

    runApp(MyApp(
      startWidget: widget,
    ));
  },
  blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

        return  MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) => CrowdCubit()..getUserData(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme:darkTheme ,
            themeMode: ThemeMode.dark,
            home: startWidget,

          ),
        );
  }

}


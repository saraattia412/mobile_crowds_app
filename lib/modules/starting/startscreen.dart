// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_crowds_app/components/default_button.dart';
import 'package:mobile_crowds_app/components/navigator.dart';
import 'package:mobile_crowds_app/modules/signup/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';


class StartScreen extends StatefulWidget {
    const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
    var boardController = PageController();

    bool isLast = false;




  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    List body=[
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            Container(
              width: width,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),),
              ),
            ),
            const Text(
              'Crowds Counting And Face Recognition',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white

              ),
            ),


          ],
        ),
      ),

      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
            Container(
              width: width/2,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),),
              ),
            ),
            const Text(
              'Crowds Counting And Face Recognition',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white

              ),
            ),


           Container(
             height: height/2,
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    defaultButton(function: (){
                      navigateTo(context, LogInScreen());
                    },
                        text: 'login'),
                    const SizedBox(
                      height: 20,
                    ),

                    defaultButton(
                        function: (){
                          navigateTo(context, SignUpScreen());
                        },
                        text: 'sign up'),

                  ],
                ),
           ),




          ],
        ),
      ),

    ];
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
                  color: Colors.white.withOpacity(.0)),
            ),
          ),
        ),
        Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (int index){
                          if(index == body.length -1){
                            print('last');
                            setState(() {
                              isLast=true;
                            });
                          }
                          else{
                            print('not last');
                            setState(() {
                              isLast=false;
                            });
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: boardController,
                        itemBuilder: (context , index)=> body[index],
                        itemCount: 2,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: 2,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                        activeDotColor: Colors.deepOrange,
                      ),

                    ),
                  ],
                )

            ),
          ),

        ),
      ],
    );
  }
}



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/time_page.dart';
import 'package:zupee/utils/routes_name.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
 WidgetsBinding.instance.addPostFrameCallback((_){
 String argument = ModalRoute.of(context,)!.settings.arguments.toString();
 print(":timeArg$argument");
 _startTimer(argument);
 });

  }

  void _startTimer(argument) {


    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _timer?.cancel();
          Navigator.pushNamed(context, RoutesName.ludoHomeScreen,arguments: argument);
        } else {
          _seconds--;

        }
      });
    });
  }
  @override
  void dispose() {
_timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesTimerPageBg), fit: BoxFit.fill)),
        child: Center(
          child: Container(
            height: height * 0.45,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.imagesTimerPage),
                    fit: BoxFit.cover)),
            child:  Column(
              children: [
                SizedBox(height: height*0.1,),
                // CountdownTimer(
                //   onTimerTick: (int value) {
                //   }, fontWeight: FontWeight.w00, fontSize: 60, color: white,
                // ),
                Text(
                  _seconds.toString(),
                  style: const TextStyle(color: white,fontSize: 60,fontWeight: FontWeight.w900),
                ),
                SizedBox(height: height*0.15,),
                const Text("Start Game...",
                  style: TextStyle(color: white,fontSize: 24,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

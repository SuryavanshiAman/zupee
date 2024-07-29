import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';

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
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
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
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: height*0.1,),
                Text(
                  _seconds.toString(),
                  style: TextStyle(color: white,fontSize: 60,fontWeight: FontWeight.w900),
                ),
                SizedBox(height: height*0.15,),
                Text("Start Game...",
                  style: TextStyle(color: white,fontSize: 24,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

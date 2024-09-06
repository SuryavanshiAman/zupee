import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/time_page.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 10;
  Timer? _timer;
  bool _hasNavigated = false;
  bool _isBlinking = false;
  @override
  void initState() {
    super.initState();
 WidgetsBinding.instance.addPostFrameCallback((_){
 _startTimer();
 });

  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _timer?.cancel();
          _startBlinking();
          // checkForFourPlayers();
        } else {
          _seconds--;
        }
      });
    });
  }
  void _startBlinking() {
    // Blinking logic
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isBlinking = !_isBlinking; // Toggle visibility for blinking effect
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
    String argument = ModalRoute.of(context)!.settings.arguments.toString();
    final documentID=Provider.of<FirebaseViewModel>(context);
    final docId=documentID.table.toString();
    CollectionReference ludoCollection = FirebaseFirestore.instance.collection('ludo');
    return
      StreamBuilder(
      // Replace '1' with the specific document ID you want to listen to
      stream: ludoCollection.doc(docId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: CircularProgressIndicator());
        }
        // Fetch the data and display it
        Map<String, dynamic> data = snapshot.data!.data() as Map<
            String,
            dynamic>;
        String player1 = data['1'] ?? '';
        String player2 = data['2'] ?? '';
        String player3 = data['3'] ?? '';
        String player4 = data['4'] ?? '';

        bool allPlayersPresent = player1.isNotEmpty && player2.isNotEmpty && player3.isNotEmpty && player4.isNotEmpty;

        if (allPlayersPresent && !_hasNavigated) {
          _hasNavigated = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacementNamed(context, RoutesName.ludoHomeScreen, arguments: argument);
            });
          });
        }
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.imagesTimerPageBg), fit: BoxFit.fill)),
            child: Center(
              child:
              Column(

                children: [
                  Spacer(),
                  Container(
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
                  SizedBox(height: height*0.1,),
                  if (_seconds == 0)
                    AnimatedOpacity(
                      opacity: _isBlinking ? 1.0 : 0.0, // Toggle opacity
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        "Waiting for other participants...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: height*0.1,),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}

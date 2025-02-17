
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/image_tost.dart';
import '../../generated/assets.dart';
import 'ludo_provider.dart';
import 'ludo_constant.dart';

class DiceWidget extends StatefulWidget {
  final List<Map<String, dynamic>> playerData;
  const DiceWidget({super.key, required this.playerData});

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  int remainingTime = 30; // Timer starts from 30 seconds
  Timer? _timer;
  int value=0;
  @override
  void initState() {
    final ludoProvider = Provider.of<LudoProvider>(context,listen: false);
    super.initState();
    ludoProvider.currentDiceIndex==0?   Future.delayed(Duration(seconds: 5),(){
      startTimer();
    }):startTimer();

  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          value =remainingTime ; // Reducing size over time
        });
      } else {

        _timer?.cancel();
        final ludoProvider = Provider.of<LudoProvider>(context,listen: false);
        ludoProvider.automaticTurnChange(context);
      }
    });
  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ludoProvider = context.watch<LudoProvider>();
    // final join = Provider.of<>(context).fieldKey;
    return InkWell(
      onTap: () {
        print("AmanJoin${ludoProvider.fieldKey}");
        print("AmanludoProvider${ludoProvider.currentDiceIndex}");
        if (ludoProvider.fieldKey == ludoProvider.currentDiceIndex) { /// original
        // if (join != ludoProvider.currentDiceIndex) {
          print("Aman");
          print(!ludoProvider.diceStarted);
          print(!ludoProvider.stopDice);
          if (!ludoProvider.diceStarted && !ludoProvider.stopDice) {
            ludoProvider.throwDice(context);
            print("Total");
          }
        } else {
          ImageToast.show(
              imagePath: Assets.imagesTextArea,
              height: height * 0.08,
              width: width * 0.6,
              context: context,
              text: "It's not your turn");
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16,10,0,0),
            child: SquarePercentIndicator(
              height:height * 0.065,
              width: width * 0.13,
              // startAngle: StartAngle.bottomRight,
              reverse: true,
              borderRadius: 12,
              shadowWidth: 1.5,
              progressWidth: 3,
              shadowColor: Colors.transparent,
              progressColor: Colors.green,
              progress: value / 30,

            ),
          ),
          Container(
            alignment: Alignment.center,
            height:height * 0.09,
            width:width * 0.2,
            padding: EdgeInsets.only(left:width*0.025 ),
            decoration: const BoxDecoration(
              //
              // image: DecorationImage(
              //   image: AssetImage(Assets.ludoDiceSectionOne),
              //   fit: BoxFit.fill,
              // ),
            ),
            child: ludoProvider.diceStarted
                ? Image.asset(
                    "assets/dice/dice.gif",
                    height:height * 0.06,
                    width: width * 0.17,
                  )
                : Image.asset(
                    "assets/dice/${ludoProvider.diceResult}.webp",
                    height:height * 0.06,
                    width:width * 0.17,
                  ),
          ),
        ],
      ),
    );
  }
}


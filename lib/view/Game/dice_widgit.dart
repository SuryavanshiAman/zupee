
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/image_tost.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/board_widgit.dart';
import 'package:zupee/view_model/join_view_model.dart';
import '../../generated/assets.dart';
import 'ludo_provider.dart';
import 'ludo_constant.dart';

class DiceWidget extends StatelessWidget {
  final List<Map<String, dynamic>> playerData;
  const DiceWidget({super.key, required this.playerData});

  @override
  Widget build(BuildContext context) {
    final ludoProvider = context.watch<LudoProvider>();
    final join = Provider.of<JoinViewModel>(context).fieldKey;
    return RippleAnimation(
      color: ludoProvider.gameState == LudoGameState.throwDice
          ? ludoProvider.currentPlayer.color
          : Colors.white.withOpacity(0),
      ripplesCount: 3,
      minRadius: 30,
      repeat: true,
      child: InkWell(
        onTap: () {
          print("AmanJoin${join}");
          print("AmanludoProvider${ludoProvider.currentDiceIndex}");
          if (join == ludoProvider.currentDiceIndex) { /// original
          // if (join != ludoProvider.currentDiceIndex) {
            if (!ludoProvider.diceStarted && !ludoProvider.stopDice) {
              ludoProvider.throwDice(context);
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
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.19,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.ludoDiceSectionOne),
              fit: BoxFit.fill,
            ),
          ),
          child: ludoProvider.diceStarted
              ? Image.asset(
                  "assets/dice/dice.gif",
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.17,
                )
              : Image.asset(
                  "assets/dice/${ludoProvider.diceResult}.webp",
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.17,
                ),
        ),
      ),
    );
  }
}

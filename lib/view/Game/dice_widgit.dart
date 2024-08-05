import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';

import 'ludo_constant.dart';
import 'ludo_provider.dart';

/// Widget for the dice
class DiceWidget extends StatelessWidget {
  const DiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LudoProvider>(
      builder: (context, value, child) =>
          RippleAnimation(
            color: value.gameState == LudoGameState.throwDice ? value
                .currentPlayer.color : Colors.white.withOpacity(0),
            ripplesCount: 3,
            minRadius: 30,
            repeat: true,
            child: InkWell(
              onTap: () {
                value.throwDice();
              },
              child: Container(
                  alignment: Alignment.center,
                  height: height * 0.08,
                  width: width * 0.19,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoDiceSectionOne),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:value.diceStarted? Image(
                      image: const AssetImage(
                       "assets/dice/dice.gif",
                      ),
                      height: height * 0.06,
                      width: width * 0.17,
                    ):Image(
                      image: AssetImage(
                        "assets/dice/${value.diceResult}.webp",
                      ),
                      height: height * 0.06,
                      width: width * 0.17,
                    ),
                  )),
            ),
          ),
    );
  }
}
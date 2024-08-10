import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';

import '../../res/app_colors.dart';
import 'ludo_constant.dart';
import 'ludo_provider.dart';

///Widget for the pawn
class PawnWidget extends StatelessWidget {
  final int index;
  final LudoPlayerType type;
  final int step;
  final bool highlight;
  final int ?initialStep;

  const PawnWidget(this.index, this.type, {Key? key, this.highlight = false, this.step = -0,this.initialStep}) : super(key: key);
  int get stepsMoved => (step != -0 && initialStep != null) ? (step - initialStep!) : 0;
  @override
  Widget build(BuildContext context) {


    Color color = Colors.white;
    switch (type) {
    case LudoPlayerType.blue:
      color = LudoColor.blue;
      break;
      case LudoPlayerType.red:
        color = LudoColor.red;
        break;
      case LudoPlayerType.green:
        color = LudoColor.green;
        break;
      case LudoPlayerType.yellow:
        color = LudoColor.yellow;
        break;


    }

    String pown = Assets.diceYellowpawn;
    switch (type) {
    case LudoPlayerType.blue:
      pown = "Assets.diceBluepawn";
      break;
      case LudoPlayerType.red:
        pown = Assets.diceRedpawn;
        break;
      case LudoPlayerType.green:
        pown = "Assets.diceGreenpawn";
        break;
      case LudoPlayerType.yellow:
        pown = Assets.diceYellowpawn;
        break;


    }

    return IgnorePointer(
      ignoring: !highlight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (highlight)
            const RippleAnimation(
              color: white,
              minRadius: 20,
              repeat: true,
              ripplesCount: 3,
              child: SizedBox.shrink(),
            ),
          Consumer<LudoProvider>(
            builder: (context, provider, child) => GestureDetector(
              onTap: () {
                if (step == -1) {
                  provider.move(type, index, (step + 1) + 1);
                } else {
                  provider.move(type, index, (step + 1) + provider.diceResult);
                }
                context.read<LudoProvider>().move(type, index, step);
              },
              child: Stack(
                  children: [
                    SizedBox(height: height*0.01,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Transform.scale(
                        scale: 2.5,
                        child: Image.asset(pown),
                      ),
                    ),
                  ]
              ),

            ),
          ),
        ],

      ),

    );
  }
}
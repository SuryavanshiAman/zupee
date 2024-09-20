
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/firebase_view_model.dart';
import 'package:zupee/view_model/timer_view_model.dart';

import 'ludo_constant.dart';
import 'ludo_player.dart';
import 'pawn_widgit.dart';
class PlayerData {
  final Map<String, dynamic>  name;
  final String score;

  PlayerData({
    required this.name,
    required this.score,
  });

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      name: json['name'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'score': score,
  };
}

///Widget for the board
class BoardWidget extends StatefulWidget {
  final List<Map<String,dynamic>> playerData;
  const BoardWidget({super.key,required this.playerData});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  ///Return board size
  double ludoBoard(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 500) {
      return 500;
    } else {
      if (width < 300) {
        return 300;
      } else {
        return width - 20;
      }
    }
  }

  ///Count box size
  double boxStepSize(BuildContext context) {
    return ludoBoard(context) / 15;
  }
  TimerProvider timerProvider=TimerProvider();
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
  final ludoProvider=Provider.of<LudoProvider>(context);
  List<PlayerData> playerDataList = [];
  for (int i = 0; i < ludoProvider.players.length; i++) {
    var player = ludoProvider.players[i];
    int totalSteps = player.pawns.fold(0, (sum, pawn) {
      return sum + (pawn.step - (pawn.initialStep ?? 0));
    });
    playerDataList.add(PlayerData(name: widget.playerData[i], score: totalSteps.toString()));
  }

// Sort the player data by score in descending order
    playerDataList.sort((a, b) => int.parse(b.score).compareTo(int.parse(a.score)));

// Get the highest, second highest, third highest, and fourth highest scores
    PlayerData? firstPlace = playerDataList.isNotEmpty ? playerDataList[0] : null;
    PlayerData? secondPlace = playerDataList.length > 1 ? playerDataList[1] : null;
    PlayerData? thirdPlace = playerDataList.length > 2 ? playerDataList[2] : null;
    PlayerData? fourthPlace = playerDataList.length > 3 ? playerDataList[3] : null;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final jsonData = jsonEncode(playerDataList.map((e) => e.toJson()).toList());
      ludoProvider.setPlayerDataFromJson(playerDataList.map((e) => e.toJson()).toList());
      ludoProvider.setTopFourPlayers(playerDataList);
    });
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: height * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.ludoLudoBoard),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<LudoProvider>(builder: (context, value, child) {

            return GridView.builder(
              padding: const EdgeInsets.only(top: 50),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 150.0, // Spacing between rows
                crossAxisSpacing: 80.0,
                childAspectRatio: 2,
              ),
              shrinkWrap: true,
              itemCount: value.players.length,
                itemBuilder: (context, itemIndex) {
                  // Sort players so that Yellow is displayed in index 2
                  List<LudoPlayer> sortedPlayers = List.from(value.players);
                  sortedPlayers.sort((a, b) {
                    if (a.type == LudoPlayerType.yellow) return 1; // Move Yellow to last
                    if (b.type == LudoPlayerType.yellow) return -1;
                    return 0; // Maintain the order for other players
                  });
                  // Ensure Yellow is displayed at index 2
                  var player = sortedPlayers[itemIndex == 2
                      ? sortedPlayers.indexWhere((p) => p.type == LudoPlayerType.yellow)
                      : itemIndex > 2
                      ? itemIndex - 1
                      : itemIndex];
                  // //
                  int totalSteps = player.pawns.fold(0, (sum, pawn) {
                    return sum + (pawn.step - (pawn.initialStep ?? 0));
                  });
                  return Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Text(
                          "Score",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: tertiary,
                          ),
                        ),
                        Text(
                          "$totalSteps",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: tertiary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

            );
          }),
        ),
        Container(
          width: width * 0.964,
          height: height * 0.474,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.ludoBoardTwo)),
          ),
          child: Consumer<LudoProvider>(
            builder: (context, value, child) {
              List<LudoPlayer> players = List.from(value.players);
              Map<String, List<PawnWidget>> pawnsRaw = {};
              Map<String, List<String>> pawnsToPrint = {};
              List<Widget> playersPawn = [];

              players.sort(
                      (a, b) => value.currentPlayer.type == a.type ? 1 : -1);

              ///Loop through all players and add their pawns to the map
              for (int i = 0; i < players.length; i++) {
                var player = players[i];
                for (int j = 0; j < player.pawns.length; j++) {
                  var pawn = player.pawns[j];
                  if (pawn.step >= 0 && pawn.step < player.path.length) {
                    String step = player.path[pawn.step].toString();
                    if (pawnsRaw[step] == null) {
                      pawnsRaw[step] = [];
                      pawnsToPrint[step] = [];
                    }
                    pawnsRaw[step]!.add(pawn);
                    pawnsToPrint[step]!.add(player.type.toString());
                  } else {
                    if (pawnsRaw["home"] == null) {
                      pawnsRaw["home"] = [];
                      pawnsToPrint["home"] = [];
                    }
                    pawnsRaw["home"]!.add(pawn);
                    pawnsToPrint["home"]!.add(player.type.toString());
                  }
                }
              }

              for (int i = 0; i < pawnsRaw.keys.length; i++) {
                String key = pawnsRaw.keys.elementAt(i);
                List<PawnWidget> pawnsValue = pawnsRaw[key]!;

                if (key == "home") {
                  playersPawn.addAll(
                    pawnsValue.map((e) {
                      var player = value.players
                          .firstWhere((element) => element.type == e.type);
                      return AnimatedPositioned(
                        key: ValueKey("${e.type.name}_${e.index}"),
                        left: LudoPath.stepBox(
                            ludoBoard(context), player.homePath[e.index][0]),
                        top: LudoPath.stepBox(
                            ludoBoard(context), player.homePath[e.index][1]),
                        width: boxStepSize(context),
                        height: boxStepSize(context),
                        duration: const Duration(milliseconds: 200),
                        child: e,
                      );
                    }),
                  );
                } else {
                  List<double> coordinates = key
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .split(",")
                      .map((e) => double.parse(e.trim()))
                      .toList();

                  if (pawnsValue.length == 1) {
                    var e = pawnsValue.first;
                    playersPawn.add(AnimatedPositioned(
                      key: ValueKey("${e.type.name}_${e.index}"),
                      duration: const Duration(milliseconds: 200),
                      left:
                      LudoPath.stepBox(ludoBoard(context), coordinates[0]),
                      top: LudoPath.stepBox(ludoBoard(context), coordinates[1]),
                      width: boxStepSize(context),
                      height: boxStepSize(context),
                      child: pawnsValue.first,
                    ));
                  } else {
                    playersPawn.addAll(
                      List.generate(
                        pawnsValue.length,
                            (index) {
                          var e = pawnsValue[index];
                          return AnimatedPositioned(
                            key: ValueKey("${e.type.name}_${e.index}"),
                            duration: const Duration(milliseconds: 200),
                            left: LudoPath.stepBox(
                                ludoBoard(context), coordinates[0]) +
                                (index * 3),
                            top: LudoPath.stepBox(
                                ludoBoard(context), coordinates[1]),
                            width: boxStepSize(context) - 5,
                            height: boxStepSize(context),
                            child: pawnsValue[index],
                          );
                        },
                      ),
                    );
                  }
                }
              }

              return Center(
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    ...playersPawn,
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );

  }

}

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:zupee/generated/assets.dart';
// // import 'package:zupee/main.dart';
// // import 'package:zupee/res/app_colors.dart';
// // import 'package:zupee/view/Game/ludo_provider.dart';
// //
// // import 'ludo_constant.dart';
// // import 'ludo_player.dart';
// // import 'pawn_widgit.dart';
// //
// // ///Widget for the board
// // class BoardWidget extends StatelessWidget {
// //   const BoardWidget({super.key});
// //
// //   ///Return board size
// //   double ludoBoard(BuildContext context) {
// //     double width = MediaQuery.of(context).size.width;
// //     if (width > 500) {
// //       return 500;
// //     } else {
// //       if (width < 300) {
// //         return 300;
// //       } else {
// //         return width - 20;
// //       }
// //     }
// //   }
// //
// //   ///Count box size
// //   double boxStepSize(BuildContext context) {
// //     return ludoBoard(context) / 15;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       alignment: Alignment.center,
// //       children: [
// //         Container(
// //             width: width,
// //             height: height * 0.5,
// //             decoration: const BoxDecoration(
// //                 image: DecorationImage(
// //                     image: AssetImage(Assets.ludoLudoBoard),
// //                     fit: BoxFit.cover)),
// //             child: Consumer<LudoProvider>(builder: (context, value, child) {
// //               return GridView.builder(
// //                 padding: const EdgeInsets.only(top: 50),
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     mainAxisSpacing: 150.0, // Spacing between rows
// //                     crossAxisSpacing: 80.0,
// //                     childAspectRatio: 2),
// //                 shrinkWrap: true,
// //                 itemCount:value.players.length ,
// //                 itemBuilder: (context, itemIndex) {
// //                   var player = value.players[itemIndex];
// //                   int totalSteps = player.pawns.fold(0, (sum, pawn) {
// //                     return sum + (pawn.step - (pawn.initialStep ?? 0));
// //                   });
// //                   return Container(
// //                     padding: const EdgeInsets.only(top: 10),
// //                     alignment: Alignment.center,
// //                     decoration: const BoxDecoration(
// //                         shape: BoxShape.circle, color: white),
// //                     child:  Column(
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         const Text("Score",
// //                             style: TextStyle(
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: 16,
// //                                 color: tertiary)),
// //                         Text(
// //                             "$totalSteps",
// //                           style: const TextStyle(
// //                               fontWeight: FontWeight.w600,
// //                               fontSize: 18,
// //                               color: tertiary),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               );
// //             })),
// //         Container(
// //           width: width * 0.964,
// //           height: height * 0.474,
// //           decoration: const BoxDecoration(
// //               image: DecorationImage(image: AssetImage(Assets.ludoBoardTwo))),
// //           child: Consumer<LudoProvider>(
// //             builder: (context, value, child) {
// //               List<LudoPlayer> players = List.from(value.players);
// //               Map<String, List<PawnWidget>> pawnsRaw = {};
// //               Map<String, List<String>> pawnsToPrint = {};
// //               List<Widget> playersPawn = [];
// //
// //               //Sort players by current turn to make sure the player on top is the one who is playing
// //               players
// //                   .sort((a, b) => value.currentPlayer.type == a.type ? 1 : -1);
// //
// //               ///Loop through all players and add their pawns to the map
// //               for (int i = 0; i < players.length; i++) {
// //                 var player = players[i];
// //                 for (int j = 0; j < player.pawns.length; j++) {
// //                   var pawn = player.pawns[j];
// //                   if (pawn.step > -1) {
// //                     String step = player.path[pawn.step].toString();
// //                     if (pawnsRaw[step] == null) {
// //                       pawnsRaw[step] = [];
// //                       pawnsToPrint[step] = [];
// //                     }
// //                     pawnsRaw[step]!.add(pawn);
// //                     pawnsToPrint[step]!.add(player.type.toString());
// //                   } else {
// //                     if (pawnsRaw["home"] == null) {
// //                       pawnsRaw["home"] = [];
// //                       pawnsToPrint["home"] = [];
// //                     }
// //                     pawnsRaw["home"]!.add(pawn);
// //                     pawnsToPrint["home"]!.add(player.type.toString());
// //                   }
// //                 }
// //               }
// //
// //               for (int i = 0; i < pawnsRaw.keys.length; i++) {
// //                 String key = pawnsRaw.keys.elementAt(i);
// //                 List<PawnWidget> pawnsValue = pawnsRaw[key]!;
// //
// //                 /// This is for every pawn in home
// //                 if (key == "home") {
// //                   playersPawn.addAll(
// //                     pawnsValue.map((e) {
// //                       var player = value.players
// //                           .firstWhere((element) => element.type == e.type);
// //                       return AnimatedPositioned(
// //                         key: ValueKey("${e.type.name}_${e.index}"),
// //                         left: LudoPath.stepBox(
// //                             ludoBoard(context), player.homePath[e.index][0]),
// //                         top: LudoPath.stepBox(
// //                             ludoBoard(context), player.homePath[e.index][1]),
// //                         width: boxStepSize(context),
// //                         height: boxStepSize(context),
// //                         duration: const Duration(milliseconds: 200),
// //                         child: e,
// //                       );
// //                     }),
// //                   );
// //                 } else {
// //                   // This is for every pawn in path (not in home)
// //                   // I'm so lazy, so make it simple h3h3
// //                   List<double> coordinates = key
// //                       .replaceAll("[", "")
// //                       .replaceAll("]", "")
// //                       .split(",")
// //                       .map((e) => double.parse(e.trim()))
// //                       .toList();
// //
// //                   if (pawnsValue.length == 1) {
// //                     // This is for 1 pawn in 1 box
// //                     var e = pawnsValue.first;
// //                     playersPawn.add(AnimatedPositioned(
// //                       key: ValueKey("${e.type.name}_${e.index}"),
// //                       duration: const Duration(milliseconds: 200),
// //                       left:
// //                           LudoPath.stepBox(ludoBoard(context), coordinates[0]),
// //                       top: LudoPath.stepBox(ludoBoard(context), coordinates[1]),
// //                       width: boxStepSize(context),
// //                       height: boxStepSize(context),
// //                       child: pawnsValue.first,
// //                     ));
// //                   } else {
// //                     // This is for more than 1 pawn in 1 box
// //                     playersPawn.addAll(
// //                       List.generate(
// //                         pawnsValue.length,
// //                         (index) {
// //                           var e = pawnsValue[index];
// //                           return AnimatedPositioned(
// //                             key: ValueKey("${e.type.name}_${e.index}"),
// //                             duration: const Duration(milliseconds: 200),
// //                             left: LudoPath.stepBox(
// //                                     ludoBoard(context), coordinates[0]) +
// //                                 (index * 3),
// //                             top: LudoPath.stepBox(
// //                                 ludoBoard(context), coordinates[1]),
// //                             width: boxStepSize(context) - 5,
// //                             height: boxStepSize(context),
// //                             child: pawnsValue[index],
// //                           );
// //                         },
// //                       ),
// //                     );
// //                   }
// //                 }
// //               }
// //
// //               return Center(
// //                 child: Stack(
// //                   fit: StackFit.expand,
// //                   alignment: Alignment.center,
// //                   children: [
// //                     ...playersPawn,
// //                     ...winners(context, value.winners),
// //                     turnIndicator(context, value.currentPlayer.type,
// //                         value.currentPlayer.color, value.gameState),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   ///This is for the turn indicator widget
// //   Widget turnIndicator(BuildContext context, LudoPlayerType turn, Color color,
// //       LudoGameState stage) {
// //     //0 is left, 1 is right
// //     int x = 0;
// //     //0 is top, 1 is bottom
// //     int y = 0;
// //
// //     switch (turn) {
// //       case LudoPlayerType.blue:
// //         x = 1;
// //         y = 1;
// //         break;
// //       case LudoPlayerType.red:
// //         x = 0;
// //         y = 1;
// //         break;
// //       case LudoPlayerType.green:
// //         x = 0;
// //         y = 0;
// //         break;
// //       case LudoPlayerType.yellow:
// //         x = 1;
// //         y = 0;
// //         break;
// //
// //
// //     }
// //     String stageText = "Roll the dice";
// //     switch (stage) {
// //       case LudoGameState.throwDice:
// //         stageText = "Roll the dice";
// //         break;
// //       case LudoGameState.moving:
// //         stageText = "Pawn is moving...";
// //         break;
// //       case LudoGameState.pickPawn:
// //         stageText = "Pick a pawn";
// //         break;
// //       case LudoGameState.finish:
// //         stageText = "Game is over";
// //         break;
// //     }
// //     return Positioned(
// //       top: y == 0 ? 0 : null,
// //       left: x == 0 ? 0 : null,
// //       right: x == 1 ? 0 : null,
// //       bottom: y == 1 ? 0 : null,
// //       width: ludoBoard(context) * .4,
// //       height: ludoBoard(context) * .4,
// //       child: IgnorePointer(
// //         child: Padding(
// //           padding: EdgeInsets.all(boxStepSize(context)),
// //           child: Container(
// //               alignment: Alignment.center,
// //               clipBehavior: Clip.antiAlias,
// //               decoration:
// //                   BoxDecoration(borderRadius: BorderRadius.circular(15)),
// //               child: RichText(
// //                 textAlign: TextAlign.center,
// //                 text: TextSpan(
// //                     style: TextStyle(fontSize: 8, color: color),
// //                     children: const [
// //                       // const TextSpan(text: "Your turn!\n", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
// //                       // TextSpan(text: stageText, style: const TextStyle(color: Colors.black)),
// //                     ]),
// //               )),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   ///This is for the winner widget
// //   List<Widget> winners(BuildContext context, List<LudoPlayerType> winners) =>
// //       List.generate(
// //         winners.length,
// //         (index) {
// //           Widget crownImage = Image.asset("assets/games/ludo/crown/1st.png");
// //
// //           //0 is left, 1 is right
// //           int x = 0;
// //           //0 is top, 1 is bottom
// //           int y = 0;
// //
// //           if (index == 0) {
// //             crownImage =
// //                 Image.asset("assets/images/crown/1st.png", fit: BoxFit.cover);
// //           } else if (index == 1) {
// //             crownImage =
// //                 Image.asset("assets/images/crown/2nd.png", fit: BoxFit.cover);
// //           } else if (index == 2) {
// //             crownImage =
// //                 Image.asset("assets/images/crown/3rd.png", fit: BoxFit.cover);
// //           } else {
// //             return Container();
// //           }
// //
// //           switch (winners[index]) {
// //             case LudoPlayerType.blue:
// //               x = 1;
// //               y = 1;
// //               break;
// //             case LudoPlayerType.red:
// //               x = 0;
// //               y = 1;
// //               break;
// //             case LudoPlayerType.green:
// //               x = 0;
// //               y = 0;
// //               break;
// //             case LudoPlayerType.yellow:
// //               x = 1;
// //               y = 0;
// //               break;
// //
// //
// //           }
// //           return Positioned(
// //             top: y == 0 ? 0 : null,
// //             left: x == 0 ? 0 : null,
// //             right: x == 1 ? 0 : null,
// //             bottom: y == 1 ? 0 : null,
// //             width: ludoBoard(context) * .4,
// //             height: ludoBoard(context) * .4,
// //             child: Padding(
// //               padding: EdgeInsets.all(boxStepSize(context)),
// //               child: Container(
// //                 clipBehavior: Clip.antiAlias,
// //                 decoration:
// //                     BoxDecoration(borderRadius: BorderRadius.circular(15)),
// //                 child: crownImage,
// //               ),
// //             ),
// //           );
// //         },
// //       );
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
// import 'package:zupee/res/app_colors.dart';
// import 'package:zupee/view/Game/ludo_constant.dart';
// import 'package:zupee/view/Game/ludo_provider.dart';
//
// import 'ludo_constant.dart';
// import 'ludo_player.dart';
// import 'pawn_widgit.dart';
//
// ///Widget for the board
// class BoardWidget extends StatelessWidget {
//   const BoardWidget({super.key});
//
//   ///Return board size
//   double ludoBoard(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     if (width > 500) {
//       return 500;
//     } else {
//       if (width < 300) {
//         return 300;
//       } else {
//         return width - 20;
//       }
//     }
//   }
//
//   ///Count box size
//   double boxStepSize(BuildContext context) {
//     return ludoBoard(context) / 15;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: width,
//           height: height * 0.5,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(Assets.ludoLudoBoard),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Consumer<LudoProvider>(builder: (context, value, child) {
//             return GridView.builder(
//               padding: const EdgeInsets.only(top: 50),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 150.0, // Spacing between rows
//                 crossAxisSpacing: 80.0,
//                 childAspectRatio: 2,
//               ),
//               shrinkWrap: true,
//               itemCount: value.players.length,
//               itemBuilder: (context, itemIndex) {
//                 var player = value.players[itemIndex];
//                 int totalSteps = player.pawns.fold(0, (sum, pawn) {
//                   return sum + (pawn.step - (pawn.initialStep ?? 0));
//                 });
//                 return Container(
//                   padding: const EdgeInsets.only(top: 10),
//                   alignment: Alignment.center,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: white,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text("Score",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: tertiary)),
//                       Text(
//                         "$totalSteps",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             color: tertiary),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }),
//         ),
//         Container(
//           width: width * 0.964,
//           height: height * 0.474,
//           decoration: const BoxDecoration(
//             image: DecorationImage(image: AssetImage(Assets.ludoBoardTwo)),
//           ),
//           child: Consumer<LudoProvider>(
//             builder: (context, value, child) {
//               List<LudoPlayer> players = List.from(value.players);
//               Map<String, List<PawnWidget>> pawnsRaw = {};
//               Map<String, List<String>> pawnsToPrint = {};
//               List<Widget> playersPawn = [];
//
//               players.sort(
//                       (a, b) => value.currentPlayer.type == a.type ? 1 : -1);
//
//               ///Loop through all players and add their pawns to the map
//               for (int i = 0; i < players.length; i++) {
//                 var player = players[i];
//                 for (int j = 0; j < player.pawns.length; j++) {
//                   var pawn = player.pawns[j];
//                   if (pawn.step >= 0 && pawn.step < player.path.length) {
//                     String step = player.path[pawn.step].toString();
//                     if (pawnsRaw[step] == null) {
//                       pawnsRaw[step] = [];
//                       pawnsToPrint[step] = [];
//                     }
//                     pawnsRaw[step]!.add(pawn);
//                     pawnsToPrint[step]!.add(player.type.toString());
//                   } else {
//                     if (pawnsRaw["home"] == null) {
//                       pawnsRaw["home"] = [];
//                       pawnsToPrint["home"] = [];
//                     }
//                     pawnsRaw["home"]!.add(pawn);
//                     pawnsToPrint["home"]!.add(player.type.toString());
//                   }
//                 }
//               }
//
//               for (int i = 0; i < pawnsRaw.keys.length; i++) {
//                 String key = pawnsRaw.keys.elementAt(i);
//                 List<PawnWidget> pawnsValue = pawnsRaw[key]!;
//
//                 if (key == "home") {
//                   playersPawn.addAll(
//                     pawnsValue.map((e) {
//                       var player = value.players
//                           .firstWhere((element) => element.type == e.type);
//                       return AnimatedPositioned(
//                         key: ValueKey("${e.type.name}_${e.index}"),
//                         left: LudoPath.stepBox(
//                             ludoBoard(context), player.homePath[e.index][0]),
//                         top: LudoPath.stepBox(
//                             ludoBoard(context), player.homePath[e.index][1]),
//                         width: boxStepSize(context),
//                         height: boxStepSize(context),
//                         duration: const Duration(milliseconds: 200),
//                         child: e,
//                       );
//                     }),
//                   );
//                 } else {
//                   List<double> coordinates = key
//                       .replaceAll("[", "")
//                       .replaceAll("]", "")
//                       .split(",")
//                       .map((e) => double.parse(e.trim()))
//                       .toList();
//
//                   if (pawnsValue.length == 1) {
//                     var e = pawnsValue.first;
//                     playersPawn.add(AnimatedPositioned(
//                       key: ValueKey("${e.type.name}_${e.index}"),
//                       duration: const Duration(milliseconds: 200),
//                       left:
//                       LudoPath.stepBox(ludoBoard(context), coordinates[0]),
//                       top: LudoPath.stepBox(ludoBoard(context), coordinates[1]),
//                       width: boxStepSize(context),
//                       height: boxStepSize(context),
//                       child: pawnsValue.first,
//                     ));
//                   } else {
//                     playersPawn.addAll(
//                       List.generate(
//                         pawnsValue.length,
//                             (index) {
//                           var e = pawnsValue[index];
//                           return AnimatedPositioned(
//                             key: ValueKey("${e.type.name}_${e.index}"),
//                             duration: const Duration(milliseconds: 200),
//                             left: LudoPath.stepBox(
//                                 ludoBoard(context), coordinates[0]) +
//                                 (index * 3),
//                             top: LudoPath.stepBox(
//                                 ludoBoard(context), coordinates[1]),
//                             width: boxStepSize(context) - 5,
//                             height: boxStepSize(context),
//                             child: pawnsValue[index],
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 }
//               }
//
//               return Center(
//                 child: Stack(
//                   fit: StackFit.expand,
//                   alignment: Alignment.center,
//                   children: [
//                     ...playersPawn,
//                     ...winners(context, value.winners.cast<LudoPlayer>()),
//                     turnIndicator(context, value.currentPlayer.type,
//                         value.currentPlayer.color, value.gameState),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   ///This is for the turn indicator widget
//   Widget turnIndicator(BuildContext context, LudoPlayerType turn, Color color,
//       LudoGameState stage) {
//     int x = 0;
//     int y = 0;
//
//     switch (turn) {
//       case LudoPlayerType.blue:
//         x = 1;
//         y = 1;
//         break;
//       case LudoPlayerType.red:
//         x = 0;
//         y = 1;
//         x = 1;
//         y = 0;
//         break;
//       case LudoPlayerType.green:
//         x = 0;
//         y = 0;
//         break;
//       case LudoPlayerType.yellow:
//         x = 1;
//         y = 0;
//         x = 0;
//         y = 1;
//         break;
//     }
//     String stageText = "Roll the dice";
//     switch (stage) {
//       case LudoGameState.throwDice:
//         stageText = "Roll the dice";
//         break;
//       case LudoGameState.moving:
//         stageText = "Pawn is moving...";
//         break;
//       case LudoGameState.pickPawn:
//         stageText = "Pick a pawn";
//         break;
//       case LudoGameState.values:
//         stageText = "Game is over";
//         break;
//     }
//     return Positioned(
//       top: y == 0 ? 0 : null,
//       left: x == 0 ? 0 : null,
//       right: x == 1 ? 0 : null,
//       bottom: y == 1 ? 0 : null,
//       width: ludoBoard(context) * .4,
//       height: ludoBoard(context) * .4,
//       child: IgnorePointer(
//         child: Padding(
//           padding: EdgeInsets.all(boxStepSize(context)),
//           child: Container(
//             alignment: Alignment.center,
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
//             child: RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 style: TextStyle(fontSize: 8, color: color),
//                 children: [
//                   TextSpan(
//                       text: "Your turn!\n",
//                       style: const TextStyle(
//                           fontSize: 12, fontWeight: FontWeight.bold)),
//                   TextSpan(text: stageText),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   ///This function checks which player has won the game and returns a list of widgets.
//   List<Widget> winners(BuildContext context, List<LudoPlayer> winners) {
//     List<Widget> winnerList = [];
//     for (int i = 0; i < winners.length; i++) {
//       var player = winners[i];
//       winnerList.add(Positioned(
//         top: player.type == LudoPlayerType.green || player.type == LudoPlayerType.yellow
//             ? boxStepSize(context) * 8
//             : boxStepSize(context) * 1.5,
//         left: player.type == LudoPlayerType.red || player.type == LudoPlayerType.green
//             ? boxStepSize(context) * 1.5
//             : boxStepSize(context) * 8,
//         child: IgnorePointer(
//           child: Container(
//             alignment: Alignment.center,
//             width: boxStepSize(context) * 3,
//             height: boxStepSize(context) * 3,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: player.color,
//                 width: 4,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: Text(
//               "Won!",
//               style: TextStyle(color: player.color),
//             ),
//           ),
//         ),
//       ));
//     }
//     return winnerList;
//   }
// }
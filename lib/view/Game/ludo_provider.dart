//
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:zupee/view/Game/ludo_constant.dart';
// import 'package:zupee/view/Game/ludo_player.dart';
//
// class LudoProvider extends ChangeNotifier {
//   bool _isMoving = false;
//   bool _stopMoving = false;
//   bool _isPlayer1Turn = true;
//   bool get isPlayer1Turn => _isPlayer1Turn;
//   LudoGameState _gameState = LudoGameState.throwDice;
//   LudoGameState get gameState => _gameState;
//   LudoPlayerType _currentTurn = LudoPlayerType.yellow;
//   LudoPlayer get currentPlayer => player(_currentTurn);
//   int _diceResult = 0;
//   int? _previousDiceResult;
//   int _totalPoints = 0;
//   int get totalPoints => _totalPoints;
//   bool _loading = false;
//   bool get loading => _loading;
//   final DocumentReference<Map<String, dynamic>> gameDoc =
//   FirebaseFirestore.instance.collection('ludo').doc('1');
//
//   LudoProvider() {
//     // Listen to changes in Firestore and update the state
//     gameDoc.snapshots().listen((snapshot) {
//       if (snapshot.exists) {
//         _diceResult = snapshot.data()?['diceResult'] ?? 1;
//         notifyListeners();
//       }
//     });
//   }
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//   int get diceResult {
//     if (_diceResult < 1) {
//       return 1;
//     } else {
//       if (_diceResult > 6) {
//         return 6;
//       } else {
//         return _diceResult;
//       }
//     }
//   }
//   int? get previousDiceResult => _previousDiceResult;
//   bool _diceStarted = false;
//   bool get diceStarted => _diceStarted;
// setDiceStarted(bool value){
//   _diceStarted=value;
//   notifyListeners();
// }
//   void switchPlayerTurn() {
//     _isPlayer1Turn = !_isPlayer1Turn;
//     notifyListeners();
//   }
//   final List<LudoPlayer> players = [
//     LudoPlayer(LudoPlayerType.blue),
//     LudoPlayer(LudoPlayerType.red),
//     LudoPlayer(LudoPlayerType.green),
//     LudoPlayer(LudoPlayerType.yellow),
//   ];
//   final List<LudoPlayerType> winners = [];
//   LudoPlayer player(LudoPlayerType type) => players.firstWhere((element) => element.type == type);
//   void throwDice() async {
//     // if (_gameState != LudoGameState.throwDice) return;
//     _diceStarted = true;
//     notifyListeners();
//     // Audio.rollDice();
//     LudoPlayer currentPlayer = player(_currentTurn);
//     if (winners.contains(currentPlayer.type)) {
//       await Future.delayed(const Duration(seconds: 1),(){
//         nextTurn();
//       });
//       return;
//     }
//     currentPlayer.highlightAllPawns(false);
//     await Future.delayed(const Duration(seconds: 1));
//     _diceStarted = false;
//     _previousDiceResult = _diceResult;
//     var random = Random();
//     _diceResult = random.nextBool() ? 5  : random.nextInt(6) + 1; //Random between 1 - 6
//     notifyListeners();
//     // Move this line here to avoid adding _diceResult twice
//     _totalPoints += (_previousDiceResult ?? 0);
//     if (diceResult==6) {
//       currentPlayer.highlightAllPawns();
//       _gameState = LudoGameState.pickPawn;
//       notifyListeners();
//       _totalPoints += _diceResult; // Add only when diceResult is 6
//     } else {
//       if (currentPlayer.pawnInsideCount != 4) {
//         currentPlayer.highlightOutside();
//         _gameState = LudoGameState.pickPawn;
//         await Future.delayed(const Duration(seconds: 1),(){
//           nextTurn();
//         });
//       } else {
//         currentPlayer.highlightOutside();
//         _gameState = LudoGameState.pickPawn;
//         notifyListeners();
//       }
//     }
//     for (var i = 0; i < currentPlayer.pawns.length; i++) {
//       var pawn = currentPlayer.pawns[i];
//       if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
//         currentPlayer.highlightPawn(i, false);
//       }
//     }
//     var moveablePawn = currentPlayer.pawns.where((e) => e.highlight).toList();
//     if (moveablePawn.length > 1) {
//       var biggestStep = moveablePawn.map((e) => e.step).reduce(max);
//       if (moveablePawn.every((element) => element.step == biggestStep)) {
//         var random = 1 + Random().nextInt(moveablePawn.length - 1);
//         if (moveablePawn[random].step == -1) {
//           var thePawn = moveablePawn[random];
//           move(thePawn.type, thePawn.index, (thePawn.step + 1) + 1);
//           return;
//         } else {
//           var thePawn = moveablePawn[random];
//           move(thePawn.type, thePawn.index, (thePawn.step + 1) + diceResult);
//           return;
//         }
//       }
//     }
//     if (currentPlayer.pawns.every((element) => !element.highlight)) {
//       if (loading==true) {
//         _gameState = LudoGameState.throwDice;
//       } else {
//         await Future.delayed(const Duration(seconds: 1),(){
//           nextTurn();
//         });
//         return;
//       }
//     }
//     if (currentPlayer.pawns.where((element) => element.highlight).length == 1) {
//       var index = currentPlayer.pawns.indexWhere((element) => element.highlight);
//       move(currentPlayer.type, index, (currentPlayer.pawns[index].step + 1) + diceResult);
//     }
//   }
//
//   void throwDicee() async {
//     if (_gameState != LudoGameState.throwDice || isPlayer1Turn) return;
//     _diceStarted = true;
//     notifyListeners();
//     // Audio.rollDice();
//     LudoPlayer currentPlayer = player(_currentTurn);
//     if (winners.contains(currentPlayer.type)) {
//       await Future.delayed(const Duration(seconds: 2),(){
//         nextTurn();
//       });
//       return;
//     }
//     currentPlayer.highlightAllPawns(false);
//     // Simulate the dice rolling delay
//     Future.delayed(const Duration(seconds: 6), () {
//       _diceStarted = false;
//       _previousDiceResult = _diceResult;
//       var random = Random();
//       _diceResult = random.nextBool() ? 5 : random.nextInt(6) + 1; // Random between 1 - 6
//       notifyListeners();
//       // Move this line here to avoid adding _diceResult twice
//       _totalPoints += (_previousDiceResult ?? 0);
//       if (loading==true) {
//         currentPlayer.highlightAllPawns();
//         _gameState = LudoGameState.pickPawn;
//         notifyListeners();
//         _totalPoints += _diceResult; // Add only when diceResult is 6
//          Future.delayed(const Duration(seconds: 2),(){
//           nextTurn();
//         });
//       } else {
//         if (currentPlayer.pawnInsideCount == 4) {
//           Future.delayed(const Duration(seconds: 2),(){
//             nextTurn();
//           });
//         } else {
//           currentPlayer.highlightOutside();
//           _gameState = LudoGameState.pickPawn;
//           notifyListeners();
//         }
//       }
//       for (var i = 0; i < currentPlayer.pawns.length; i++) {
//         var pawn = currentPlayer.pawns[i];
//         if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
//           currentPlayer.highlightPawn(i, false);
//         }
//       }
//       var moveablePawn = currentPlayer.pawns.where((e) => e.highlight).toList();
//       if (moveablePawn.length > 1) {
//         var biggestStep = moveablePawn.map((e) => e.step).reduce(max);
//         if (moveablePawn.every((element) => element.step == biggestStep)) {
//           var random = 1 + Random().nextInt(moveablePawn.length - 1);
//           if (moveablePawn[random].step == -1) {
//             var thePawn = moveablePawn[random];
//             move(thePawn.type, thePawn.index, (thePawn.step + 1) + 1);
//             return;
//           } else {
//             var thePawn = moveablePawn[random];
//             move(thePawn.type, thePawn.index, (thePawn.step + 1) + diceResult);
//             return;
//           }
//         }
//       }
//       if (currentPlayer.pawns.every((element) => !element.highlight)) {
//         if (loading==true) {
//           _gameState = LudoGameState.throwDice;
//         } else {
//            Future.delayed(const Duration(seconds: 2),(){
//             nextTurn();
//           });
//           return;
//         }
//       }
//       if (currentPlayer.pawns.where((element) => element.highlight).length == 1) {
//         var index = currentPlayer.pawns.indexWhere((element) => element.highlight);
//         move(currentPlayer.type, index, (currentPlayer.pawns[index].step + 1) + diceResult);
//       }
//     });
//   }
//
//   void move(LudoPlayerType type, int index, int step) async {
//     if (_isMoving) return;
//     _isMoving = true;
//     _gameState = LudoGameState.moving;
//     LudoPlayer currentPlayer = player(type);
//     currentPlayer.highlightAllPawns(false);
//     int currentStep = currentPlayer.pawns[index].step;
//
//     // for (int i = currentStep + 1; i <= step; i++) {
//     //   if (_stopMoving) break;
//     //
//     //   currentPlayer.movePawn(index, i); // Move pawn step-by-step
//     //   notifyListeners();
//     //
//     //   await Future.delayed(const Duration(milliseconds: 300)); // Adjust the delay for desired animation speed
//     //
//     //   if (_stopMoving) break;
//     // }
//     for (int i = currentPlayer.pawns[index].step; i < step; i++) {
//       if (_stopMoving) break;
//       if (currentPlayer.pawns[index].step == i) continue;
//       currentPlayer.movePawn(index, i);
//       await Future.delayed(const Duration(milliseconds:300));
//       // await Audio.playMove();
//       notifyListeners();
//       if (_stopMoving) break;
//     }
//     if (checkToKill(type, index, step, currentPlayer.path)) {
//       _gameState = LudoGameState.throwDice;
//       _isMoving = false;
//       // Audio.playKill();
//       notifyListeners();
//       return;
//     }
//     validateWin(type);
//     if (loading==true) {
//       _gameState = LudoGameState.throwDice;
//       notifyListeners();
//     } else {
//       Future.delayed(const Duration(seconds: 2),(){
//         nextTurn();
//       });
//       notifyListeners();
//     }
//     _isMoving = false;
//   }
//   bool checkToKill(LudoPlayerType type, int index, int step, List<List<double>> path) {
//     bool killSomeone = false;
//     for (int i = 0; i < 4; i++) {
//       var redElement = player(LudoPlayerType.red).pawns[i];
//       var yellowElement = player(LudoPlayerType.yellow).pawns[i];
//       if ((yellowElement.step > -1 && !LudoPath.safeArea.map((e) => e.toString()).contains(player(LudoPlayerType.yellow).path[yellowElement.step].toString())) && type != LudoPlayerType.yellow) {
//         if (player(LudoPlayerType.yellow).path[yellowElement.step].toString() == path[step - 1].toString()) {
//           killSomeone = true;
//           player(LudoPlayerType.yellow).movePawn(i, -1);
//           notifyListeners();
//         }
//       }
//       if ((redElement.step > -1 && !LudoPath.safeArea.map((e) => e.toString()).contains(player(LudoPlayerType.red).path[redElement.step].toString())) && type != LudoPlayerType.red) {
//         if (player(LudoPlayerType.red).path[redElement.step].toString() == path[step - 1].toString()) {
//           killSomeone = true;
//           player(LudoPlayerType.red).movePawn(i, -1);
//           notifyListeners();
//         }
//       }
//     }
//     return killSomeone;
//   }
//   void validateWin(LudoPlayerType color) {
//     if (winners.map((e) => e.name).contains(color.name)) return;
//     if (player(color).pawns.map((e) => e.step).every((element) => element == player(color).path.length - 1)) {
//       winners.add(color);
//       notifyListeners();
//     }
//     if (winners.length == 3) {
//       _gameState = LudoGameState.finish;
//     }
//   }
//   void nextTurn() {
//     switch (_currentTurn) {
//       case LudoPlayerType.blue:
//         _currentTurn = LudoPlayerType.green;
//         break;
//       case LudoPlayerType.yellow:
//         _currentTurn = LudoPlayerType.red;
//         break;
//       case LudoPlayerType.green:
//         _currentTurn = LudoPlayerType.blue;
//         break;
//       case LudoPlayerType.red:
//         _currentTurn = LudoPlayerType.yellow;
//         break;
//     }
//     if (winners.contains(_currentTurn)) return nextTurn();
//     _gameState = LudoGameState.throwDice;
//     notifyListeners();
//   }
//   @override
//   void dispose() {
//     _stopMoving = true;
//     super.dispose();
//   }
// }
/// working 23-08
/// latest working26-08
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:zupee/view_model/firebase_view_model.dart';
// import 'ludo_constant.dart';
// import 'ludo_player.dart';
//
// class LudoProvider extends ChangeNotifier {
//   bool _isMoving = false;
//   LudoGameState _gameState = LudoGameState.throwDice;
//   int _diceResult = 1;
//   bool _diceStarted = false;
//   LudoPlayerType _currentTurn = LudoPlayerType.yellow;
//
//   final List<LudoPlayer> players = [
//     LudoPlayer(LudoPlayerType.blue),
//     LudoPlayer(LudoPlayerType.red),
//     LudoPlayer(LudoPlayerType.green),
//     LudoPlayer(LudoPlayerType.yellow),
//   ];
//   FirebaseViewModel firebaseViewModel = FirebaseViewModel();
//   final List<LudoPlayerType> winners = [];
//   late final DocumentReference<Map<String, dynamic>> gameDoc;
//
//   LudoProvider(this.firebaseViewModel) {
//     print("firebaseViewModel:${firebaseViewModel.table.toString()}");
//     gameDoc = FirebaseFirestore.instance.collection('ludo').doc("1");
//     _listenToGameUpdates();
//   }
//   // final DocumentReference<Map<String, dynamic>> gameDoc = FirebaseFirestore
//   //     .instance
//   //     .collection('ludo')
//   //     .doc(firebaseViewModel.table.toString());
//
//   // LudoProvider() {
//   //   _listenToGameUpdates();
//   // }
//
//   void _listenToGameUpdates() {
//     gameDoc.snapshots().listen((snapshot) {
//       if (snapshot.exists) {
//         var data = snapshot.data();
//         if (data != null) {
//           _diceResult = data['diceResult'] ?? 1;
//           _currentTurn = LudoPlayerType.values[data['currentTurn'] ?? 3];
//           _gameState = LudoGameState.values[data['gameState'] ?? 0];
//
//           var playersData = data['players'];
//           if (playersData != null) {
//             for (var playerType in LudoPlayerType.values) {
//               var pawnsData = playersData[playerType.toString()];
//               if (pawnsData != null) {
//                 for (int i = 0;
//                     i < players[playerType.index].pawns.length;
//                     i++) {
//                   players[playerType.index].pawns[i].step = pawnsData[i];
//                 }
//               }
//             }
//           }
//
//           notifyListeners(); // Notify listeners of any state change
//         }
//       }
//     });
//   }
//
//   LudoPlayer get currentPlayer => player(_currentTurn);
//   bool get diceStarted => _diceStarted;
//   int get diceResult => _diceResult;
//   LudoGameState get gameState => _gameState;
//
//   LudoPlayer player(LudoPlayerType type) =>
//       players.firstWhere((element) => element.type == type);
//
//   void throwDice() async {
//     _diceStarted = true;
//     notifyListeners();
//
//     _diceResult = Random().nextInt(6) + 1;
//
//     await gameDoc.update({
//       'diceResult': _diceResult,
//       'currentTurn': _currentTurn.index,
//       'gameState': LudoGameState.pickPawn.index,
//     });
//
//     _diceStarted = false;
//     notifyListeners();
//
//     if (_diceResult != 6) {
//       if (currentPlayer.pawnInsideCount == 4) {
//         await Future.delayed(const Duration(seconds: 1));
//         nextTurn();
//       } else {
//         currentPlayer.highlightOutside();
//         _gameState = LudoGameState.pickPawn;
//         notifyListeners();
//       }
//     } else {
//       // When 6 is rolled, the player gets another chance
//       currentPlayer.highlightOutside();
//       _gameState = LudoGameState.pickPawn;
//       notifyListeners();
//     }
//
//     ///Check and disable if any pawn already in the finish box
//     for (var i = 0; i < currentPlayer.pawns.length; i++) {
//       var pawn = currentPlayer.pawns[i];
//       if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
//         currentPlayer.highlightPawn(i, false);
//       }
//     }
//
//     ///If User have 6 dice, but it inside finish line, it will make him to throw again, else it will turn to next player
//     if (currentPlayer.pawns.every((element) => !element.highlight)) {
//       if (diceResult == 6) {
//         _gameState = LudoGameState.throwDice;
//       } else {
//         nextTurn();
//         return;
//       }
//     }
//
//     // if (currentPlayer.pawns.where((element) => element.highlight).length == 1) {
//     //   var index = currentPlayer.pawns.indexWhere((element) => element.highlight);
//     //   move(currentPlayer.type, index, (currentPlayer.pawns[index].step + 1) + diceResult);
//     // }
//   }
//
//   void move(LudoPlayerType type, int index, int step) async {
//     if (_isMoving) return;
//     _isMoving = true;
//     _gameState = LudoGameState.moving;
//     LudoPlayer currentPlayer = player(type);
//     currentPlayer.highlightAllPawns(false);
//     for (int i = currentPlayer.pawns[index].step; i <= step; i++) {
//       currentPlayer.movePawn(index, i);
//       await Future.delayed(const Duration(milliseconds: 300));
//       // await gameDoc.update({
//       //   'players.${type.toString()}':
//       //   players[type.index].pawns.map((pawn) => pawn.step).toList(),
//       //   'currentTurn': _currentTurn.index,
//       //   'gameState': _gameState.index,
//       // });
//       notifyListeners();
//     }
//     if (checkToKill(type, index, step, currentPlayer.path)) {
//       _gameState = LudoGameState.throwDice;
//       _isMoving = false;
//       notifyListeners();
//       return;
//     }
//
//     validateWin(type);
//     nextTurn();
//     _isMoving = false;
//     notifyListeners();
//   }
//
//   bool checkToKill(LudoPlayerType type, int index, int step, List<List<double>> path) {
//     bool killSomeone = false;
//
//     for (int i = 0; i < 4; i++) {
//       var greenElement = player(LudoPlayerType.green).pawns[i];
//       var blueElement = player(LudoPlayerType.blue).pawns[i];
//       var redElement = player(LudoPlayerType.red).pawns[i];
//       var yellowElement = player(LudoPlayerType.yellow).pawns[i];
//
//       // Check for green pawns
//       if ((greenElement.step > 0 && !LudoPath.safeArea.contains(greenElement.step)) && type != LudoPlayerType.green) {
//         if (player(LudoPlayerType.green).path[greenElement.step] == path[step]) {
//           killSomeone = true;
//           player(LudoPlayerType.green).movePawn(i, 0);
//           _sendPawnMovementToFirestore(LudoPlayerType.green, i, 0); // Reset in Firestore
//           notifyListeners();
//         }
//       }
//
//       // Repeat similar logic for blue, red, and yellow pawns...
//
//       // Check for blue pawns
//       if ((blueElement.step > 0 && !LudoPath.safeArea.contains(blueElement.step)) && type != LudoPlayerType.blue) {
//         if (player(LudoPlayerType.blue).path[blueElement.step] == path[step]) {
//           killSomeone = true;
//           player(LudoPlayerType.blue).movePawn(i, 0);
//           _sendPawnMovementToFirestore(LudoPlayerType.blue, i, 0); // Reset in Firestore
//           notifyListeners();
//         }
//       }
//
//       // Check for red pawns
//       if ((redElement.step > 0 && !LudoPath.safeArea.contains(redElement.step)) && type != LudoPlayerType.red) {
//         if (player(LudoPlayerType.red).path[redElement.step] == path[step]) {
//           killSomeone = true;
//           player(LudoPlayerType.red).movePawn(i, 0);
//           _sendPawnMovementToFirestore(LudoPlayerType.red, i, 0); // Reset in Firestore
//           notifyListeners();
//         }
//       }
//
//       // Check for yellow pawns
//       if ((yellowElement.step > 0 && !LudoPath.safeArea.contains(yellowElement.step)) && type != LudoPlayerType.yellow) {
//         if (player(LudoPlayerType.yellow).path[yellowElement.step] == path[step]) {
//           killSomeone = true;
//           player(LudoPlayerType.yellow).movePawn(i, 0);
//           _sendPawnMovementToFirestore(LudoPlayerType.yellow, i, 0); // Reset in Firestore
//           notifyListeners();
//         }
//       }
//     }
//
//     return killSomeone;
//   }
//   // bool checkToKill(
//   //     LudoPlayerType type, int index, int step, List<List<double>> path) {
//   //   bool killSomeone = false;
//   //   for (int i = 0; i < 4; i++) {
//   //     var redElement = player(LudoPlayerType.red).pawns[i];
//   //     var yellowElement = player(LudoPlayerType.yellow).pawns[i];
//   //     if ((yellowElement.step > 0 && !LudoPath.safeArea.map((e) => e.toString()).contains(player(LudoPlayerType.yellow).path[yellowElement.step]
//   //         .toString())) &&
//   //         type != LudoPlayerType.yellow) {
//   //       if (player(LudoPlayerType.yellow).path[yellowElement.step].toString() ==
//   //           path[step - 0].toString()) {
//   //         killSomeone = true;
//   //         player(LudoPlayerType.yellow).movePawn(i, -0);
//   //         notifyListeners();
//   //       }
//   //     }
//   //     if ((redElement.step > 0 &&
//   //             !LudoPath.safeArea.map((e) => e.toString()).contains(
//   //                 player(LudoPlayerType.red)
//   //                     .path[redElement.step]
//   //                     .toString())) &&
//   //         type != LudoPlayerType.red) {
//   //       if (player(LudoPlayerType.red).path[redElement.step].toString() ==
//   //           path[step - 0].toString()) {
//   //         killSomeone = true;
//   //         player(LudoPlayerType.red).movePawn(i, -0);
//   //         notifyListeners();
//   //       }
//   //     }
//   //   }
//   //   return killSomeone;
//   // }
//
//   void validateWin(LudoPlayerType color) {
//     if (winners.contains(color)) return;
//     if (player(color)
//         .pawns
//         .every((pawn) => pawn.step == player(color).path.length - 1)) {
//       winners.add(color);
//       notifyListeners();
//     }
//     if (winners.length == 3) {
//       _gameState = LudoGameState.finish;
//       notifyListeners();
//     }
//   }
//
//   void nextTurn() async {
//     if (_diceResult == 6) {
//       // Skip the turn change if a 6 was rolled
//       _gameState = LudoGameState.throwDice;
//       notifyListeners();
//       return;
//     }
// ///original
//     // switch (_currentTurn) {
//     //   case LudoPlayerType.blue:
//     //     _currentTurn = LudoPlayerType.green;
//     //     break;
//     //   case LudoPlayerType.yellow:
//     //     _currentTurn = LudoPlayerType.red;
//     //     break;
//     //   case LudoPlayerType.green:
//     //     _currentTurn = LudoPlayerType.blue;
//     //     break;
//     //   case LudoPlayerType.red:
//     //     _currentTurn = LudoPlayerType.yellow;
//     //     break;
//     // }
//
//     switch (_currentTurn) {
//       case LudoPlayerType.blue:
//         _currentTurn = LudoPlayerType.red;
//         break;
//       case LudoPlayerType.red:
//         _currentTurn = LudoPlayerType.green;
//         break;
//       case LudoPlayerType.green:
//         _currentTurn = LudoPlayerType.yellow;
//         break;
//       case LudoPlayerType.yellow:
//         _currentTurn = LudoPlayerType.blue;
//         break;
//     }
//
//     if (winners.contains(_currentTurn)) return nextTurn();
//     _gameState = LudoGameState.throwDice;
//
//     await gameDoc.update({
//       'currentTurn': _currentTurn.index,
//       'gameState': _gameState.index,
//     });
//
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'ludo_constant.dart';
import 'ludo_player.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

class LudoProvider extends ChangeNotifier {
  bool _isMoving = false;
  bool _stopDice=false;
  bool get isMoving => _isMoving;
  bool get stopDice => _stopDice;

  LudoGameState _gameState = LudoGameState.throwDice;
  int _diceResult = 1;
  bool _diceStarted = false;
  LudoPlayerType _currentTurn = LudoPlayerType.yellow;

  final List<LudoPlayer> players = [
    LudoPlayer(LudoPlayerType.blue),
    LudoPlayer(LudoPlayerType.red),
    LudoPlayer(LudoPlayerType.green),
    LudoPlayer(LudoPlayerType.yellow),
  ];

  final List<LudoPlayerType> winners = [];
  DocumentReference<Map<String, dynamic>>? gameDoc;

  // LudoProvider() {
  //   gameDoc = FirebaseFirestore.instance.collection('ludo').doc();
  //   _listenToGameUpdates();
  // }



  void _listenToGameUpdates() {
    gameDoc!.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null) {
          _diceResult = data['diceResult'] ?? 1;
          _currentTurn = LudoPlayerType.values[data['currentTurn'] ?? 3];
          _gameState = LudoGameState.values[data['gameState'] ?? 0];

          var playersData = data['players'];
          if (playersData != null) {
            for (var playerType in LudoPlayerType.values) {
              var pawnsData = playersData[playerType.toString()];
              if (pawnsData != null) {
                for (int i = 0;
                i < players[playerType.index].pawns.length;
                i++) {
                  players[playerType.index].pawns[i].step = pawnsData[i];
                }
              }
            }
          }

          notifyListeners();
        }
      }
    });
  }

  LudoPlayer get currentPlayer => player(_currentTurn);
  bool get diceStarted => _diceStarted;
  int get diceResult => _diceResult;
  LudoGameState get gameState => _gameState;

  LudoPlayer player(LudoPlayerType type) =>
      players.firstWhere((element) => element.type == type);

  void throwDice(context) async {
    _diceStarted = true;
    _stopDice=true;
    notifyListeners();
    final firebaseViewModel = Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    if(gameDoc == null){
      gameDoc = FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel);
    }else{
      print("skdkdkd");
    }
    _listenToGameUpdates();

    print("Firehaimai${firebaseViewModel}");

    _diceResult = Random().nextInt(6) + 1;

     gameDoc!.update({
      'diceResult': _diceResult,
      'currentTurn': _currentTurn.index,
      'gameState': LudoGameState.pickPawn.index,
    });
     Future.delayed(const Duration(milliseconds: 500),(){
       _diceStarted = false;
       notifyListeners();
     });


    if (_diceResult != 6) {
      if (currentPlayer.pawnInsideCount == 4) {
        await Future.delayed(const Duration(seconds: 1));
        nextTurn();
      } else {
        currentPlayer.highlightOutside();
        _gameState = LudoGameState.pickPawn;
        notifyListeners();
      }
    } else {
      // When 6 is rolled, the player gets another chance
      currentPlayer.highlightOutside();
      _gameState = LudoGameState.pickPawn;
      notifyListeners();
    }

    for (var i = 0; i < currentPlayer.pawns.length; i++) {
      var pawn = currentPlayer.pawns[i];
      if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
        currentPlayer.highlightPawn(i, false);
      }
    }

    if (currentPlayer.pawns.every((element) => !element.highlight)) {
      if (diceResult == 6) {
        _gameState = LudoGameState.throwDice;
      } else {
        nextTurn();
        return;
      }
    }
  }

  void move(context,LudoPlayerType type, int index, int step) async {
    if (_isMoving) return;
    _isMoving = true;
    _stopDice=false;
    // notifyListeners();
    _gameState = LudoGameState.moving;
    LudoPlayer currentPlayer = player(type);
    currentPlayer.highlightAllPawns(false);
    for (int i = currentPlayer.pawns[index].step; i <= step; i++) {
      currentPlayer.movePawn(index, i);
      await Future.delayed(const Duration(milliseconds: 320));
      // gameDoc!.update({
      //   '${type.toString().split('.').last}PawnPosition$index': step,
      // });
      notifyListeners();
    }
    if (await checkToKill(context,type, index, step, currentPlayer.path)) {
      _gameState = LudoGameState.throwDice;
      _isMoving = false;
      notifyListeners();
      return;
    }

    validateWin(type);
    nextTurn();
    _isMoving = false;
    notifyListeners();
  }
  Future<bool> checkToKill(context,LudoPlayerType type, int index, int step, List<List<double>> path) async{
    bool killSomeone = false;
    final firebaseViewModel = Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    for (var opponentType in LudoPlayerType.values.where((t) => t != type)) {
      for (int i = 0; i < 4; i++) {
        var opponentPawn = player(opponentType).pawns[i];

        if (opponentPawn.step > 0) {
          bool isInSafeArea = LudoPath.safeArea
              .map((e) => e.toString())
              .contains(player(opponentType).path[opponentPawn.step].toString());

          if (!isInSafeArea) {
            if (player(opponentType).path[opponentPawn.step].toString() == path[step].toString()) {
              killSomeone = true;

              // Reset the opponent's pawn to the initial position
              // await _movePawnBackToInitial(opponentType, i, opponentPawn.step);
              // opponentPawn.step = 0;
              Future.microtask(() async {
                for (int j = opponentPawn.step; j >= 0; j--) {
                  await Future.delayed(const Duration(milliseconds: 25));  // Reduce the delay for faster movement
                  opponentPawn.step = j;
                  FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel).update({
                    '${opponentType.toString().split('.').last}PawnPosition$i': opponentPawn.step,
                  });
                  notifyListeners();
                }
              });

              // gameDoc.update({
              //               'players.${opponentType.toString()}': players[opponentType.index]
              //                   .pawns
              //                   .map((pawn) => pawn.step)
              //                   .toList(),
              //             });
              notifyListeners();

              print('Pawn of $opponentType at index $i was killed by player $type at step $step.');
              print('Opponent pawn reset to step: ${opponentPawn.step}');
            }
          }
        }
      }
    }

    return killSomeone;
  }
  Future<void> _movePawnBackToInitial(LudoPlayerType opponentType, int pawnIndex, int currentStep) async {
    var opponentPlayer = player(opponentType);

    // Move the pawn backward step by step to the initial position
    for (int i = currentStep; i >= 0; i--) {
      opponentPlayer.pawns[pawnIndex].step = i;

      // Update Firebase with the current step of the opponent's pawn
      await FirebaseFirestore.instance.collection('ludo').doc("1").update({
        '${opponentType.toString().split('.').last}PawnPosition$pawnIndex': i,
      });

      // Wait a short time before moving to the next step
      // await Future.delayed(const Duration(milliseconds: 2));

      notifyListeners();
    }
  }

  // bool checkToKill(LudoPlayerType type, int index, int step, List<List<double>> path) {
  //   bool killSomeone = false;
  //
  //   for (int i = 0; i < 4; i++) {
  //     var opponentTypes = LudoPlayerType.values.where((t) => t != type);
  //     for (var opponentType in opponentTypes) {
  //       var opponentPawn = player(opponentType).pawns[i];
  //
  //       if (opponentPawn.step > 0 &&
  //           !LudoPath.safeArea
  //               .map((e) => e.toString())
  //               .contains(player(opponentType).path[opponentPawn.step].toString())) {
  //         if (player(opponentType).path[opponentPawn.step].toString() ==
  //             path[step].toString()) {
  //           killSomeone = true;
  //           opponentPawn.step = 0; // Send pawn back to start
  //           gameDoc.update({
  //             'players.${opponentType.toString()}': players[opponentType.index]
  //                 .pawns
  //                 .map((pawn) => pawn.step)
  //                 .toList(),
  //           });
  //           notifyListeners();
  //         }
  //       }
  //     }
  //   }
  //   return killSomeone;
  // }

  void validateWin(LudoPlayerType color) {
    if (winners.contains(color)) return;
    if (player(color)
        .pawns
        .every((pawn) => pawn.step == player(color).path.length - 1)) {
      winners.add(color);
      notifyListeners();
    }
    if (winners.length == 3) {
      _gameState = LudoGameState.finish;
      notifyListeners();
    }
  }

  void nextTurn() async {
    if (_diceResult == 6) {
      _gameState = LudoGameState.throwDice;
      notifyListeners();
      return;
    }

    switch (_currentTurn) {
      case LudoPlayerType.blue:
        _currentTurn = LudoPlayerType.red;
        break;
      case LudoPlayerType.red:
        _currentTurn = LudoPlayerType.green;
        break;
      case LudoPlayerType.green:
        _currentTurn = LudoPlayerType.yellow;
        break;
      case LudoPlayerType.yellow:
        _currentTurn = LudoPlayerType.blue;
        break;
    }

    if (winners.contains(_currentTurn)) return nextTurn();
    _gameState = LudoGameState.throwDice;

    await gameDoc!.update({
      'currentTurn': _currentTurn.index,
      'gameState': _gameState.index,
    });

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
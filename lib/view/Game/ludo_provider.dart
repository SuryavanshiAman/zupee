
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:zupee/view/Game/board_widgit.dart';
import 'ludo_constant.dart';
import 'ludo_player.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

class LudoProvider with ChangeNotifier {
  bool _isMoving = false;
  int _playerQuantity=0;
  bool _stopDice=false;
  bool get isMoving => _isMoving;
  bool get stopDice => _stopDice;
  int get playerQuantity=>_playerQuantity;


  LudoGameState _gameState = LudoGameState.throwDice;
  int _diceResult = 1;
  bool _diceStarted = false;
  LudoPlayerType _currentTurn = LudoPlayerType.blue;
  DocumentReference<Map<String, dynamic>>? gameDoc;

  int _currentDiceIndex =0;
  int get currentDiceIndex => _currentDiceIndex;

  void setCurrentDiceIndex(int val){
    _currentDiceIndex=val;
    notifyListeners();
  }

   List<LudoPlayer> players = [
    LudoPlayer(LudoPlayerType.blue),
    LudoPlayer(LudoPlayerType.red),
    LudoPlayer(LudoPlayerType.green),
    LudoPlayer(LudoPlayerType.yellow),
  ];

  List<dynamic> _playerDataList = [];

  List<dynamic> get playerDataList => _playerDataList;
  PlayerData? firstPlace;
  PlayerData? secondPlace;
  PlayerData? thirdPlace;
  PlayerData? fourthPlace;

  // Other existing properties and methods
void setPlayerQuantity(int value){
  _playerQuantity=value;
  notifyListeners();
}
  void setTopFourPlayers(List<PlayerData> playerDataList) async {
    // Sort the player data by score in descending order
    playerDataList.sort((a, b) => int.parse(b.score).compareTo(int.parse(a.score)));

    // Set the top four players
    firstPlace = playerDataList.isNotEmpty ? playerDataList[0] : null;
    secondPlace = playerDataList.length > 1 ? playerDataList[1] : null;
    thirdPlace = playerDataList.length > 2 ? playerDataList[2] : null;
    fourthPlace = playerDataList.length > 3 ? playerDataList[3] : null;

    notifyListeners();
  }
  // Setter method to set player data from JSON
  void setPlayerDataFromJson(dynamic jsonData) {
    _playerDataList=List.from(jsonData);
      notifyListeners();
  }
  final List<LudoPlayerType> winners = [];

  void listenToGameUpdates(context) {
    final firebaseViewModel = Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    gameDoc = FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel);
    gameDoc!.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        print("Listening for updates: $data");
        if (data != null) {
          _diceResult = data['diceResult'] ?? 1;
          _currentTurn = LudoPlayerType.values[data['currentTurn'] ?? 0];
          // setCurrentDiceIndex(data['currentTurn']??0);
          _currentDiceIndex= data['currentTurn']??0;
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
      if (kDebugMode) {
        print("skdkdkd");
      }
    }
    gameDoc!.update({
      'diceResult': _diceResult,
      'currentTurn': _currentTurn.index,
      'currentDiceIndex':_currentDiceIndex,
      'gameState': LudoGameState.pickPawn.index,
    });
    listenToGameUpdates(context);

    if (kDebugMode) {
      print("Firehaimai$firebaseViewModel");
    }

    _diceResult = Random().nextInt(6) + 1;


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
      print("i= $i || index = $index");
      currentPlayer.movePawn(index, i);

      gameDoc?.update({
        '${type.toString().split('.').last}PawnPosition$index':i,
      });
      await Future.delayed(const Duration(milliseconds: 320));
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

              Future.microtask(() async {
                for (int j = opponentPawn.step; j >= 0; j--) {
                  await Future.delayed(const Duration(milliseconds: 50));  // Reduce the delay for faster movement
                  opponentPawn.step = j;
                  FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel).update({
                    '${opponentType.toString().split('.').last}PawnPosition$i': opponentPawn.step,
                  });
                  notifyListeners();
                }
              });

              notifyListeners();

              if (kDebugMode) {
                print('Pawn of $opponentType at index $i was killed by player $type at step $step.');
              }
              if (kDebugMode) {
                print('Opponent pawn reset to step: ${opponentPawn.step}');
              }
            }
          }
        }
      }
    }

    return killSomeone;
  }

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

  void resetPawns(context, firebaseViewModel) async {
   print(" firebaseViewModel$firebaseViewModel");

     for (var player in players) {
       for (var i = 0; i < player.pawns.length; i++) {
         player.pawns[i].step = 0; // Reset to the initial position
         _currentTurn = LudoPlayerType.blue;
         // Update Firestore with the reset position
         await FirebaseFirestore.instance.collection('ludo').doc(
             firebaseViewModel.toString()).update({
           '${player.type
               .toString()
               .split('.')
               .last}PawnPosition$i': 0, 'currentTurn': _currentTurn.index,
           'currentDiceIndex':_currentDiceIndex,
         });
       }
     }
  
    notifyListeners(); // Notify listeners to rebuild the UI
  }
  void nextTurn() async {
    if (_diceResult == 6) {
      _gameState = LudoGameState.throwDice;
      notifyListeners();
      return;
    }

  // switch (_currentTurn) {
  //   case LudoPlayerType.blue:
  //     _currentTurn = LudoPlayerType.red;
  //     break;
  //   case LudoPlayerType.red:
  //     _currentTurn = LudoPlayerType.green;
  //     break;
  //   case LudoPlayerType.green:
  //     _currentTurn = LudoPlayerType.yellow;
  //     break;
  //   case LudoPlayerType.yellow:
  //     _currentTurn = LudoPlayerType.blue;
  //     break;
  // }
    if(playerQuantity!=2) {
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
    }else{

      switch (_currentTurn) {
        case LudoPlayerType.blue:
          _currentTurn = LudoPlayerType.green;
          break;
        case LudoPlayerType.green:
          _currentTurn = LudoPlayerType.blue;
          break;

        case LudoPlayerType.green:
        // TODO: Handle this case.
        case LudoPlayerType.yellow:
        // TODO: Handle this case.
        case LudoPlayerType.red:
          // TODO: Handle this case.
      }}
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
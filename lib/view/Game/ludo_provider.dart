import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/image_tost.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/board_widgit.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import '../../view_model/join_view_model.dart';
import 'ludo_constant.dart';

import 'ludo_player.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

class LudoProvider with ChangeNotifier {
  bool _isMoving = false;
  bool _status = false;
  bool get status => _status;
  int _playerQuantity = 0;
  int _documentId = 1;
  int get documentId => _documentId;
  String _entryAmount = "0";
  String get entryAmount => _entryAmount;
  bool _stopDice = false;
  bool get isMoving => _isMoving;
  bool get stopDice => _stopDice;
  int get playerQuantity => _playerQuantity;
  String _tournamentId = "0";
  String get tournamentId => _tournamentId;
  bool _isConnected = true;
  bool get isConnected => _isConnected;
  int _selectedAvatarIndex = 0;
  String? _selectedAvatarImage;
  File? _aadhaarImage;
  File? get aadhaarImage =>_aadhaarImage;
  File? _aadhaarBackImage;
  File? get aadhaarBackImage =>_aadhaarBackImage;
  File? _panImage;
  File? get panImage =>_panImage;
  void setAadhaarImage(File?value){
    _aadhaarImage = value;
    notifyListeners();
  }
  void setAadhaarBackImage(File?value){
    _aadhaarBackImage = value;
    notifyListeners();
  }
  void setPanImage(File?value){
    _panImage = value;
    notifyListeners();
  }
  String? aadhaarBase64Image;
  String? aadhaarBackBase64Image;
  String? panBase64Image;
  Future<void> getAadhaarImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _aadhaarImage = File(pickedFile.path);
      aadhaarBase64Image = base64Encode(_aadhaarImage!.readAsBytesSync());
      notifyListeners();
    }
  }
  Future<void> getAadhaarBackImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _aadhaarBackImage = File(pickedFile.path);
      aadhaarBackBase64Image = base64Encode(_aadhaarBackImage!.readAsBytesSync());
      notifyListeners();
    }
  }
  Future<void> getPanImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _panImage = File(pickedFile.path);
      panBase64Image = base64Encode(_panImage!.readAsBytesSync());
      notifyListeners();
    }
  }
  int get selectedAvatarIndex => _selectedAvatarIndex;
  String? get selectedAvatarImage => _selectedAvatarImage;
  String? _base64Image;
  void setAvatar(int index, String imagePath) async {
    _selectedAvatarIndex = index;
    _selectedAvatarImage = imagePath;
    ByteData byteData = await rootBundle.load(_selectedAvatarImage!);
    final bytes = byteData.buffer.asUint8List();
    _base64Image = base64Encode(bytes);
    notifyListeners();
  }

  File? _image;
  final picker = ImagePicker();

  File? get image => _image;
  String? get base64Image => _base64Image;
  void setImage(File value) {
    _image = value;
    notifyListeners();
  }

  // Function to pick an image and encode it to base64
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      _selectedAvatarImage = null;
      notifyListeners();
    }
  }

  void updateDocumentId(int newId) {
    _documentId = newId;
    notifyListeners();
  }

  void setStatus(bool value) {
    _status = value;
    notifyListeners();
  }
  void setEntryAmount(String value) {
    _entryAmount = value;
    notifyListeners();
  }
  void setConnection(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  String _prizePool = "0";
  String get prizePool => _prizePool;
  int _fieldKey = 1;
  int get fieldKey => _fieldKey;
  setFieldKey(int value) {
    if (value == 0) {
      _fieldKey = value;
    } else {
      _fieldKey = value - 1;
    }
    notifyListeners();
  }

  LudoGameState _gameState = LudoGameState.throwDice;
  int _diceResult = 1;
  bool _diceStarted = false;
  LudoPlayerType _currentTurn = LudoPlayerType.blue;
  DocumentReference<Map<String, dynamic>>? gameDoc;

  int _currentDiceIndex = -1;
  int get currentDiceIndex => _currentDiceIndex;

  void setCurrentDiceIndex(int val) {
    _currentDiceIndex = val;
    notifyListeners();
  }

  void setTournamentID(String value) {
    _tournamentId = value;
    notifyListeners();
  }

  void setPrizePool(String value) {
    _prizePool = value;
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

  void setPlayerQuantity(int value) {
    _playerQuantity = value;
    notifyListeners();
  }

  void setTopFourPlayers(List<PlayerData> playerDataList) async {
    playerDataList
        .sort((a, b) => int.parse(b.score).compareTo(int.parse(a.score)));

    firstPlace = playerDataList.isNotEmpty ? playerDataList[0] : null;
    secondPlace = playerDataList.length > 1 ? playerDataList[1] : null;
    thirdPlace = playerDataList.length > 2 ? playerDataList[2] : null;
    fourthPlace = playerDataList.length > 3 ? playerDataList[3] : null;

    notifyListeners();
  }

  void setPlayerDataFromJson(dynamic jsonData) {
    _playerDataList = List.from(jsonData);
    notifyListeners();
  }

  final List<LudoPlayerType> winners = [];

  void listenToGameUpdates(context) {
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    gameDoc =
        FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel);
    gameDoc!.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null) {
          _diceResult = data['diceResult'] ?? 1;
          _currentTurn = LudoPlayerType.values[data['currentTurn'] ?? 0];
          _currentDiceIndex = data['currentTurn'] ?? 0;
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
bool _home=false;

  bool get home => _home;

  setHome(bool value) {
    _home = value;
    notifyListeners();
  }
  dynamic _myData;
  dynamic get myData => _myData;
  int _myPosition = 0;
  int get myPosition => _myPosition;
  setMyData(profile) {
    _myData = _playerDataList.firstWhere(
      (player) => player['name']['id'] == profile?.data?.id.toString(),
      orElse: () => null,
    );
    notifyListeners();
  }

  setMyPosition(profile) {
    _myPosition = playerDataList.indexWhere(
            (player) => player['name']['id'] == profile?.data?.id.toString()) +
        1;
  }

  LudoPlayer get currentPlayer => player(_currentTurn);
  bool get diceStarted => _diceStarted;
  int get diceResult => _diceResult;
  LudoGameState get gameState => _gameState;
  LudoPlayer player(LudoPlayerType type) =>
      players.firstWhere((element) => element.type == type);
  void automaticTurnChange(context)async {
    _diceStarted = false;
    _stopDice = false;
    notifyListeners();
    final firebaseViewModel =
    Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    if (gameDoc == null) {
      gameDoc =
          FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel);
    } else {
      if (kDebugMode) {
        print("skdkdkd");
      }
    }
    // _diceResult = Random().nextInt(6) + 1;
    gameDoc!.update({
      'diceResult': 1,
      'currentTurn': _currentTurn.index,
      'gameState': LudoGameState.pickPawn.index,
    });
    listenToGameUpdates(context);

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   _diceStarted = false;
    //   notifyListeners();
    // });
    nextTurn();
    // if (_diceResult != 6) {
    //   if (currentPlayer.pawnInsideCount == 4) {
    //     await Future.delayed(const Duration(seconds: 1));
    //     nextTurn();
    //   } else {
    //     currentPlayer.highlightOutside();
    //     _gameState = LudoGameState.pickPawn;
    //     notifyListeners();
    //   }
    // } else {
    //   // When 6 is rolled, the player gets another chance
    //   currentPlayer.highlightOutside();
    //   _gameState = LudoGameState.pickPawn;
    //   notifyListeners();
    // }
    // for (var i = 0; i < currentPlayer.pawns.length; i++) {
    //   var pawn = currentPlayer.pawns[i];
    //   if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
    //     currentPlayer.highlightPawn(i, false);
    //   }
    // }
    // if (currentPlayer.pawns.every((element) => !element.highlight)) {
    //   if (diceResult == 6) {
    //     _gameState = LudoGameState.throwDice;
    //   } else {
    //     nextTurn();
    //     return;
    //   }
    // }
  }
  void throwDice(context) async {
    _diceStarted = true;
    _stopDice = true;
    notifyListeners();
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    if (gameDoc == null) {
      gameDoc =
          FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel);
    } else {
      if (kDebugMode) {
        print("skdkdkd");
      }
    }
    _diceResult = Random().nextInt(6) + 1;
    gameDoc!.update({
      'diceResult': _diceResult,
      'currentTurn': _currentTurn.index,
      'gameState': LudoGameState.pickPawn.index,
    });
    listenToGameUpdates(context);

    Future.delayed(const Duration(milliseconds: 500), () {
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

  void move(context, LudoPlayerType type, int index, int step) async {
    if (_isMoving) return;
    _isMoving = true;
    _stopDice = false;
    _gameState = LudoGameState.moving;

    LudoPlayer currentPlayer = player(type);
    currentPlayer.highlightAllPawns(false);
    int currentStep = currentPlayer.pawns[index].step;
    print("Shweta${currentStep}");
     currentStep==56?print("abcdefghAman"):null;
    for (int i = currentPlayer.pawns[index].step; i <= step; i++) {
      currentPlayer.movePawn(index, i);
      if(
      i==56
      ){
        setHome(true);
        ImageToast.show(
            imagePath: Assets.imagesTextArea,
            height: height * 0.08,
            width: width * 0.6,
            context: context,
            text: "Home");
        Future.delayed(const Duration(seconds: 2),(){
          setHome(false);
        });

      }else{};
      gameDoc?.update({
        '${type.toString().split('.').last}PawnPosition$index': i,
      });
      await Future.delayed(const Duration(milliseconds: 320));
      notifyListeners();
    }
    if (await checkToKill(context, type, index, step, currentPlayer.path)) {
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

  Future<bool> checkToKill(context, LudoPlayerType type, int index, int step,
      List<List<double>> path) async {
    bool killSomeone = false;
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false).table.toString();
    for (var opponentType in LudoPlayerType.values.where((t) => t != type)) {
      for (int i = 0; i < 4; i++) {
        var opponentPawn = player(opponentType).pawns[i];

        if (opponentPawn.step > 0) {
          bool isInSafeArea = LudoPath.safeArea
              .map((e) => e.toString())
              .contains(
                  player(opponentType).path[opponentPawn.step].toString());

          if (!isInSafeArea) {
            if (player(opponentType).path[opponentPawn.step].toString() ==
                path[step].toString()) {
              killSomeone = true;

              Future.microtask(() async {
                for (int j = opponentPawn.step; j >= 0; j--) {
                  await Future.delayed(const Duration(
                      milliseconds:
                          50)); // Reduce the delay for faster movement
                  opponentPawn.step = j;
                  FirebaseFirestore.instance
                      .collection('ludo')
                      .doc(firebaseViewModel)
                      .update({
                    '${opponentType.toString().split('.').last}PawnPosition$i':
                        opponentPawn.step,
                  });
                  notifyListeners();
                }
              });

              notifyListeners();

              if (kDebugMode) {
                print(
                    'Pawn of $opponentType at index $i was killed by player $type at step $step.');
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
    for (var player in players) {
      for (var i = 0; i < player.pawns.length; i++) {
        player.pawns[i].step = 0;
        _currentTurn = LudoPlayerType.blue;
        // Update Firestore with the reset position
        await FirebaseFirestore.instance
            .collection('ludo')
            .doc(firebaseViewModel.toString())
            .update({
          '${player.type.toString().split('.').last}PawnPosition$i': 0,
          'currentTurn': _currentTurn.index,
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

    if (playerQuantity != 2) {
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
    } else {
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
      }
    }
    if (winners.contains(_currentTurn)) return nextTurn();
    _gameState = LudoGameState.throwDice;

    await gameDoc!.update({
      'currentTurn': _currentTurn.index,
      'gameState': _gameState.index,
    });

    notifyListeners();
  }
  void addMember(context) async {
    final join = Provider.of<JoinViewModel>(context, listen: false);
    final profile = Provider.of<ProfileViewModel>(context, listen: false).profileResponse;
    final firebaseViewModel = Provider.of<FirebaseViewModel>(context, listen: false);
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    CollectionReference ludoCollection = fireStore.collection('ludo');
    bool isAdded = false;
    final playerColors = players;
    final twoPlayer = (playerQuantity == 2);

    while (!isAdded) {
      DocumentSnapshot documentSnapshot = await ludoCollection.doc(documentId.toString()).get();

      if (!documentSnapshot.exists) {
        print("Creating new document with ID $documentId");
        Map<String, dynamic> jsonData = twoPlayer
            ? {
          "1": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}',
          "3": '',
          "isLocked": false,
          "playerQuantity": 2,
          "prizePool": prizePool
        }
            : {
          "1": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}',
          "2": '',
          "3": '',
          "4": '',
          "isLocked": false,
          "playerQuantity": 4,
          "prizePool": prizePool
        };

        await ludoCollection.doc(documentId.toString()).set(jsonData);
        setFieldKey(1); // Set fieldKey for the first position
        isAdded = true;
      } else {
        // Fetch the document data once and use it to perform multiple checks
        Map<String, dynamic>? existingData = documentSnapshot.data() as Map<String, dynamic>?;

        if (existingData != null) {
          if (existingData["prizePool"] != prizePool) {
            print("Table has a different prize pool, moving to a new table...");
            updateDocumentId(documentId + 1); // Move to the next table
            continue;
          }

          if (existingData["playerQuantity"] != playerQuantity) {
            print("Table is meant for ${existingData['playerQuantity']} players, moving to a new table...");
            updateDocumentId(documentId + 1); // Move to the next table
            continue;
          }

          if (existingData["isLocked"] == true) {
            print("Table is locked, moving to a new table...");
            updateDocumentId(documentId + 1); // Move to the next table
            continue;
          }

          // Parallel check for 2-player game slots
          if (twoPlayer) {
            final List<bool> slotsFilled = [existingData["1"], existingData["3"]].map((slot) => slot != null && slot != '').toList();
            if (slotsFilled.every((isFilled) => isFilled)) {
              print("Both positions in 2-player table are filled, locking table...");
              await ludoCollection.doc(documentId.toString()).update({"isLocked": true});
              updateDocumentId(documentId + 1); // Move to a new table
              continue;
            }

            // Add the player to an empty slot
            if (!slotsFilled[0]) {
              await ludoCollection.doc(documentId.toString()).update({
                "1": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[0].type}"}'
              });
              setFieldKey(1);
              isAdded = true;
            } else if (!slotsFilled[1]) {
              await ludoCollection.doc(documentId.toString()).update({
                "3": '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[2].type}"}'
              });
              setFieldKey(3);
              isAdded = true;
            }
          } else {
            // Parallel check for 4-player game slots
            final List<bool> slotsFilled = [
              existingData["1"],
              existingData["2"],
              existingData["3"],
              existingData["4"]
            ].map((slot) => slot != null && slot != '').toList();

            if (slotsFilled.every((isFilled) => isFilled)) {
              print("All positions in 4-player table are filled, locking table...");
              await ludoCollection.doc(documentId.toString()).update({"isLocked": true});
              updateDocumentId(documentId + 1); // Move to a new table
              continue;
            }

            // Add the player to an empty slot
            for (int i = 0; i < slotsFilled.length; i++) {
              if (!slotsFilled[i]) {
                String fieldKey = (i + 1).toString();
                await ludoCollection.doc(documentId.toString()).update({
                  fieldKey: '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}","number":"${profile.data!.mobileNumber}","color":"${playerColors[i].type}"}'
                });
                setFieldKey(i + 1);
                isAdded = true;
                break;
              }
            }
          }
        }

        if (!isAdded) {
          updateDocumentId(documentId + 1); // Move to a new table
        }
      }
    }

    if (isAdded) {
      firebaseViewModel.setTable(documentId);
      join.joinApi(tournamentId.toString(), documentId.toString(), prizePool, context).then((_) {
        resetPawns(context, documentId);
      });
    }
  }


  removePlayerData(context) async {
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false);
    final ludoProvider = Provider.of<LudoProvider>(context, listen: false);
    final documentID = firebaseViewModel.table.toString();
    CollectionReference ludoCollection =
        FirebaseFirestore.instance.collection('ludo');

    // Get the field key for the current player
    int fieldKey = ludoProvider.fieldKey + 1;

    // Update Firestore to remove the current player's data
    await ludoCollection.doc(documentID).update({
      fieldKey.toString(): '', // Clear the player's data
    });

    // Reset the pawns for the current player
    var currentPlayer =
        ludoProvider.players[fieldKey - 1]; // Assuming players is a list
    for (var i = 0; i < currentPlayer.pawns.length; i++) {
      print("😢😢😢😢😢");
      currentPlayer.pawns[i].step = 0; // Reset to initial position
      // Update Firestore with the reset pawn position
      await ludoCollection.doc(documentID).update({
        '${currentPlayer.type.toString().split('.').last}PawnPosition$i': 0,
      });
    }

    // Optionally lock the table
    await ludoCollection.doc(documentID).update({"isLocked": true});

    // Notify listeners to rebuild the UI
    notifyListeners();
  }

  removePlayerName(context) async {
    final firebaseViewModel =
        Provider.of<FirebaseViewModel>(context, listen: false);
    final ludoProvider = Provider.of<LudoProvider>(context, listen: false);
    final documentID = firebaseViewModel.table.toString();
    CollectionReference ludoCollection =
        FirebaseFirestore.instance.collection('ludo');

    // Get the field key for the current player
    int fieldKey = ludoProvider.fieldKey + 1;

    // Update Firestore to remove the current player's data
    await ludoCollection.doc(documentID).update({
      fieldKey.toString(): '', // Clear the player's data
    });

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

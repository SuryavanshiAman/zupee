// abstract class BaseApiServices {
//   Future<dynamic> getGetApiResponse(String url);
//
//   Future<dynamic> getPostApiResponse(String url, dynamic data);
//
//   Future<dynamic> getFormApiResponse(String url, Map<String, String> fields, List<http.MultipartFile> files);
// }
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:zupee/helper/app_exception.dart';
// import 'package:zupee/res/app_constant.dart';
//
// import 'base_api_services.dart';
//
// class NetworkApiServices extends BaseApiServices {
//   @override
//   Future getGetApiResponse(String url) async {
//     dynamic responseJson;
//     try {
//       final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: AppConstants.timeOut));
//       if (kDebugMode) {
//         print('Api Url : $url');
//       }
//       responseJson = returnRequest(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   @override
//   Future getPostApiResponse(String url, dynamic data) async {
//     dynamic responseJson;
//     try {
//       final response = await http.post(Uri.parse(url), body: data).timeout(const Duration(seconds: AppConstants.timeOut));
//       if (kDebugMode) {
//         print('Api Url : $url');
//       }
//       responseJson = returnRequest(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   @override
//   Future getFormApiResponse(String url, Map<String, String> fields, List<http.MultipartFile> files) async {
//     dynamic responseJson;
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(url))
//         ..fields.addAll(fields)
//         ..files.addAll(files);
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       if (kDebugMode) {
//         print('Api Url : $url');
//       }
//       responseJson = returnRequest(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   dynamic returnRequest(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = jsonDecode(response.body);
//         if (kDebugMode) {
//           print('response 200: $responseJson');
//         }
//         return responseJson;
//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 404:
//         throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         throw FetchDataException('Error occurred while communicating with server with status code ${response.statusCode}');
//     }
//   }
// }
// import 'package:zupee/res/api_url.dart';
// import '../helper/network/base_api_services.dart';
// import '../helper/network/network_api_services.dart';
// import '../model/about_model.dart';
// import 'package:http/http.dart' as http;
//
// class AboutRepository {
//   final BaseApiServices _apiServices = NetworkApiServices();
//
//   Future<AboutModel> aboutApi() async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse(ApiUrl.getAboutDataApi);
//       return AboutModel.fromJson(response);
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error occurred during aboutApi: $e');
//       }
//       rethrow;
//     }
//   }
//
//   Future<AboutModel> uploadDataWithFile(Map<String, String> fields, List<http.MultipartFile> files) async {
//     try {
//       dynamic response = await _apiServices.getFormApiResponse(ApiUrl.uploadDataApi, fields, files);
//       return AboutModel.fromJson(response);
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error occurred during uploadDataWithFile: $e');
//       }
//       rethrow;
//     }
//   }
// }
// import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
// import 'package:zupee/res/api_url.dart';
// import 'package:zupee/view_model/user_view_model.dart';
// import 'package:zupee/view_model/auth_repository.dart';
// import 'package:zupee/utils/utils.dart';
// import 'package:http/http.dart' as http;
//
// class AuthViewModel with ChangeNotifier {
//   final _authRepo = AuthRepository();
//
//   bool _loading = false;
//
//   bool get loading => _loading;
//
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//   Future<void> authApi(dynamic phone, context) async {
//     final userPref = Provider.of<UserViewModel>(context, listen: false);
//
//     setLoading(true);
//     Map<String, String> fields = {
//       "mobile_number": phone,
//     };
//
//     List<http.MultipartFile> files = []; // Add files if any
//
//     _authRepo.uploadDataWithFile(fields, files).then((value) {
//       if (value.status == "201") {
//         setLoading(false);
//         userPref.saveUser(value.data.id.toString());
//         sedOtpApi(phone, context);
//         Navigator.pushNamed(context, RoutesName.verifyPage, arguments: {
//           "phone": phone,
//         });
//         Utils.showSuccessToast(value.message);
//       } else if (value.status == "200") {
//         setLoading(false);
//         userPref.saveUser(value.data.id.toString());
//         sedOtpApi(phone, context);
//         Navigator.pushNamed(context, RoutesName.verifyPage, arguments: {
//           "phone": phone,
//         });
//         Utils.showSuccessToast(value.message);
//       } else {
//         setLoading(false);
//         Utils.showErrorToast(value.message);
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       if (kDebugMode) {
//         print('registerError: $error');
//       }
//     });
//   }
// }
// import 'package:http/http.dart' as http;
//
// Future<void> uploadProfilePicture(String userId, String filePath, String description) async {
//   setLoading(true);
//   try {
//     Map<String, String> fields = {
//       "userId": userId,
//       "description": description,
//     };
//
//     List<http.MultipartFile> files = [
//       await http.MultipartFile.fromPath('file', filePath),
//     ];
//
//     var response = await _authRepo.uploadDataWithFile(fields, files);
//     // Handle the response
//
//     setLoading(false);
//   } catch (e) {
//     setLoading(false);
//     // Handle the error
//   }
// }


/// form data api structure





// class ModelDownloaderViewModel with ChangeNotifier {
//   final DigitalInkRecognizerModelManager _modelManager = DigitalInkRecognizerModelManager();
//   bool _isDownloading = false;
//   String _statusMessage = 'Idle';
//
//   bool get isDownloading => _isDownloading;
//   String get statusMessage => _statusMessage;
//
//   ModelDownloaderViewModel() {
//     _checkAndDownloadModel();
//   }
//
//   Future<void> _checkAndDownloadModel() async {
//     _statusMessage = 'Checking model status...';
//     notifyListeners();
//
//     try {
//       bool isDownloaded = await _modelManager.isModelDownloaded('en');
//       if (isDownloaded) {
//         _statusMessage = 'Model is already downloaded.';
//         notifyListeners();
//         return;
//       }
//
//       _statusMessage = 'Checking connectivity...';
//       notifyListeners();
//
//       ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult == ConnectivityResult.none) {
//         _statusMessage = 'No internet connection. Download queued.';
//         notifyListeners();
//         return;
//       }
//
//       _isDownloading = true;
//       _statusMessage = 'Downloading model...';
//       notifyListeners();
//
//       try {
//         bool success = await _modelManager.downloadModel('en');
//         _isDownloading = false;
//         _statusMessage = success ? 'Model downloaded successfully.' : 'Failed to download model.';
//         notifyListeners();
//       } catch (e) {
//         _isDownloading = false;
//         _statusMessage = 'Error occurred during model download: $e';
//         notifyListeners();
//         if (kDebugMode) {
//           print('Error occurred during model download: $e');
//         }
//       }
//     } catch (e) {
//       _statusMessage = 'Error checking model status: $e';
//       notifyListeners();
//       if (kDebugMode) {
//         print('Error checking model status: $e');
//       }
//     }
//   }
// }
// // Update with the correct path
//
// class ModelDownloaderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Model Downloader'),
//       ),
//       body: Center(
//         child: Consumer<ModelDownloaderViewModel>(
//           builder: (context, model, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (model.isDownloading)
//                   CircularProgressIndicator(),
//                 SizedBox(height: 20),
//                 Text(model.statusMessage),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'dart:math';
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
//
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//   int get diceResult {
//     if (_diceResult < 1) {
//       return 1;
//     } else if (_diceResult > 6) {
//       return 6;
//     } else {
//       return _diceResult;
//     }
//   }
//
//   int? get previousDiceResult => _previousDiceResult;
//   bool _diceStarted = false;
//   bool get diceStarted => _diceStarted;
//
//   setDiceStarted(bool value) {
//     _diceStarted = value;
//     notifyListeners();
//   }
//
//   final List<LudoPlayer> players = [
//     LudoPlayer(LudoPlayerType.blue),
//     LudoPlayer(LudoPlayerType.red),
//     LudoPlayer(LudoPlayerType.green),
//     LudoPlayer(LudoPlayerType.yellow),
//   ];
//
//   final List<LudoPlayerType> winners = [];
//
//   LudoPlayer player(LudoPlayerType type) => players.firstWhere((element) => element.type == type);
//
//   void switchPlayerTurn() {
//     _isPlayer1Turn = !_isPlayer1Turn;
//     notifyListeners();
//   }
//
//   void throwDice() async {
//     if (_gameState != LudoGameState.throwDice) return;
//     _diceStarted = true;
//     notifyListeners();
//
//     LudoPlayer currentPlayer = player(_currentTurn);
//
//     // Skip turn if player is already a winner
//     if (winners.contains(currentPlayer.type)) {
//       await Future.delayed(const Duration(seconds: 1), nextTurn);
//       return;
//     }
//
//     currentPlayer.highlightAllPawns(false);
//     await Future.delayed(const Duration(seconds: 1));
//
//     _diceStarted = false;
//     _previousDiceResult = _diceResult;
//
//     // Roll the dice
//     _diceResult = Random().nextInt(6) + 1; // Random between 1 - 6
//     notifyListeners();
//
//     _totalPoints += (_previousDiceResult ?? 0);
//
//     if (diceResult == 6) {
//       currentPlayer.highlightAllPawns();
//       _gameState = LudoGameState.pickPawn;
//       notifyListeners();
//       _totalPoints += _diceResult;
//     } else {
//       if (currentPlayer.pawnInsideCount != 4) {
//         currentPlayer.highlightOutside();
//         _gameState = LudoGameState.pickPawn;
//         await Future.delayed(const Duration(seconds: 1), nextTurn);
//       } else {
//         currentPlayer.highlightOutside();
//         _gameState = LudoGameState.pickPawn;
//       }
//     }
//
//     for (var i = 0; i < currentPlayer.pawns.length; i++) {
//       var pawn = currentPlayer.pawns[i];
//       if ((pawn.step + diceResult) > currentPlayer.path.length - 1) {
//         currentPlayer.highlightPawn(i, false);
//       }
//     }
//
//     var moveablePawn = currentPlayer.pawns.where((e) => e.highlight).toList();
//     if (moveablePawn.length > 1) {
//       var biggestStep = moveablePawn.map((e) => e.step).reduce(max);
//       if (moveablePawn.every((element) => element.step == biggestStep)) {
//         var randomIndex = 1 + Random().nextInt(moveablePawn.length - 1);
//         var thePawn = moveablePawn[randomIndex];
//         move(thePawn.type, thePawn.index, thePawn.step + diceResult + 1);
//         return;
//       }
//     }
//
//     if (currentPlayer.pawns.every((element) => !element.highlight)) {
//       _gameState = LudoGameState.throwDice;
//       await Future.delayed(const Duration(seconds: 1), nextTurn);
//       return;
//     }
//
//     if (moveablePawn.length == 1) {
//       var index = currentPlayer.pawns.indexWhere((element) => element.highlight);
//       move(currentPlayer.type, index, currentPlayer.pawns[index].step + diceResult + 1);
//     }
//   }
//
//   void move(LudoPlayerType type, int index, int step) async {
//     if (_isMoving) return;
//
//     _isMoving = true;
//     _gameState = LudoGameState.moving;
//     LudoPlayer currentPlayer = player(type);
//     currentPlayer.highlightAllPawns(false);
//
//     for (int i = currentPlayer.pawns[index].step; i < step; i++) {
//       if (_stopMoving) break;
//       if (currentPlayer.pawns[index].step == i) continue;
//       currentPlayer.movePawn(index, i);
//       notifyListeners();
//       if (_stopMoving) break;
//     }
//
//     if (checkToKill(type, index, step, currentPlayer.path)) {
//       _gameState = LudoGameState.throwDice;
//     } else {
//       validateWin(type);
//       nextTurn();
//     }
//
//     _isMoving = false;
//     notifyListeners();
//   }
//
//   bool checkToKill(LudoPlayerType type, int index, int step, List<List<double>> path) {
//     bool killSomeone = false;
//     for (var playerType in [LudoPlayerType.red, LudoPlayerType.yellow]) {
//       if (type == playerType) continue;
//
//       var opponent = player(playerType);
//       for (var pawn in opponent.pawns) {
//         if (pawn.step > -1 &&
//             !LudoPath.safeArea.contains(opponent.path[pawn.step]) &&
//             opponent.path[pawn.step] == path[step - 1]) {
//           killSomeone = true;
//           opponent.movePawn(pawn.index, -1);
//           notifyListeners();
//         }
//       }
//     }
//     return killSomeone;
//   }
//
//   void validateWin(LudoPlayerType color) {
//     if (winners.contains(color)) return;
//
//     if (player(color).pawns.every((pawn) => pawn.step == player(color).path.length - 1)) {
//       winners.add(color);
//       notifyListeners();
//     }
//
//     if (winners.length == 3) {
//       _gameState = LudoGameState.finish;
//     }
//   }
//
//   void nextTurn() {
//     _currentTurn = LudoPlayerType.values[(_currentTurn.index + 1) % LudoPlayerType.values.length];
//     if (winners.contains(_currentTurn)) return nextTurn();
//     _gameState = LudoGameState.throwDice;
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     _stopMoving = true;
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPinField extends StatefulWidget {
  final int pinLength;
  final ValueChanged<String>? onCompleted;
  final TextStyle? textStyle;
  final BoxDecoration? decoration;
  final Color cursorColor;

  const CustomPinField({
    Key? key,
    required this.pinLength,
    this.onCompleted,
    this.textStyle,
    this.decoration,
    this.cursorColor = Colors.black,
  }) : super(key: key);

  @override
  _CustomPinFieldState createState() => _CustomPinFieldState();
}

class _CustomPinFieldState extends State<CustomPinField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _pinValues;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.pinLength, (_) => TextEditingController());
    _focusNodes = List.generate(widget.pinLength, (_) => FocusNode());
    _pinValues = List.generate(widget.pinLength, (_) => '');

    for (int i = 0; i < widget.pinLength; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < widget.pinLength - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onFieldChanged(String value, int index) {
    setState(() {
      _pinValues[index] = value;
    });

    if (_pinValues.every((v) => v.isNotEmpty)) {
      widget.onCompleted?.call(_pinValues.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          width: 44,
          height: 44,
          decoration: widget.decoration ??
              BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            cursorColor: widget.cursorColor,
            style: widget.textStyle ?? const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (value) {
              _onFieldChanged(value, index);
              if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}


class PinEntryPage extends StatelessWidget {
  const PinEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter PIN')),
      body: Center(
        child: CustomPinField(
          pinLength: 6,
          onCompleted: (pin) {
            // Handle PIN completion
            print("Entered PIN: $pin");
          },
          textStyle: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          ),
          cursorColor: Colors.orange,
        ),
      ),
    );
  }
}



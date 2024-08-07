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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/chat_model.dart';
import 'package:zupee/repo/get_chat_repo.dart';

import '../helper/response/api_response.dart';
import 'user_view_model.dart';

class GetChatViewModel with ChangeNotifier {
  final _getChatRepo =GetChatRepository();

  ApiResponse<ChatModel> getChatList = ApiResponse.loading();

  setGetChatList(ApiResponse<ChatModel> response) {
    getChatList = response;
    notifyListeners();
  }

  Future<void>getChatApi(BuildContext context ) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setGetChatList(ApiResponse.loading());
    _getChatRepo.getChatApi(userId).then((value) {
      if (value.status == "success") {
        setGetChatList(ApiResponse.completed(value));
      } else {
        if (kDebugMode) {
          print('value:');
        }
      }
    }).onError((error, stackTrace) {
      setGetChatList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

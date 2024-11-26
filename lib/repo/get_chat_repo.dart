import 'package:flutter/foundation.dart';
import 'package:zupee/model/chat_model.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class GetChatRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ChatModel> getChatApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getChatApi+data);
      return ChatModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during chatGetApi: $e');
      }
      rethrow;
    }
  }
}
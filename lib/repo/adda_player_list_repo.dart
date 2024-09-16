import 'package:flutter/foundation.dart';
import 'package:zupee/model/player_rank_model.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class PlayerRankRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<PlayerRankModel> playerRankApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.userRank);
      return PlayerRankModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addaPlayerListApi: $e');
      }
      rethrow;
    }
  }
}
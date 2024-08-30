import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class ConfirmPaymentRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> confirmPaymentApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(ApiUrl.joinTournamentApi , data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during confirmPaymentApi: $e');
      }
      rethrow;
    }
  }
}
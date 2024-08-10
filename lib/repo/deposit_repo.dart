import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class DepositRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> depositApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.depositApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during depositApi: $e');
      }
      rethrow;
    }
  }
}
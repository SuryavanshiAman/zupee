
import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class SendResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> sendResultApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.sendResultApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during sendResultApi: $e');
      }
      rethrow;
    }
  }
}
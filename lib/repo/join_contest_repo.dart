import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class JoinRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> joinApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.joinApi,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during joinApi: $e');
      }
      rethrow;
    }
  }
}
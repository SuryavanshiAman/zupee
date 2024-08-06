import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class ViewBankDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> viewBankDetailsApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(ApiUrl.accountViewApi , data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during viewBankDetailsApi: $e');
      }
      rethrow;
    }
  }
}
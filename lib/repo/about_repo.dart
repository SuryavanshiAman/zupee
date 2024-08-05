import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';
import '../model/about_model.dart';

class AboutRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<AboutModel> aboutApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getAboutDataApi);
      return AboutModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during aboutApi: $e');
      }
      rethrow;
    }
  }
}
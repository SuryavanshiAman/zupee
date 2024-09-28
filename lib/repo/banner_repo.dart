import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class BannerRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> bannerApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(ApiUrl.bannerApi);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during bannerApi: $e');
      }
      rethrow;
    }
  }
}
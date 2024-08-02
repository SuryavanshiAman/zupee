import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';


class ProfileUpdateRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> profileUpdateApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.updateProfileApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during profileUpdateApi: $e');
      }
      rethrow;
    }
  }}
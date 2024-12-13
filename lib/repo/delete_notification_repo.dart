import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class DeleteNotificationRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> deleteNotificationApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.notificationsDelete, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during deleteNotificationApi: $e');
      }
      rethrow;
    }
  }
}
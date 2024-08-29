import 'package:flutter/foundation.dart';
import 'package:zupee/model/ContestCategoryModel.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class ContestCategoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ContestCategoriesModel> contestCategoryApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.contestCategoriesApi);
      return ContestCategoriesModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during contestCategoryApi: $e');
      }
      rethrow;
    }
  }
}
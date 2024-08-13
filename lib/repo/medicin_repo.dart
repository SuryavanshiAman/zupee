import 'package:flutter/foundation.dart';
import 'package:zupee/model/medical_model.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class MedicineRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MedicalModel> medicineApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.medicineApi,data);
      return MedicalModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during medicineApi: $e');
      }
      rethrow;
    }
  }
}
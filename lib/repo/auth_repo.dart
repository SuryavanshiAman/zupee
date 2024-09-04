
import 'package:flutter/foundation.dart';
import 'package:zupee/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> authApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.authApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during loginApi: $e');
      }
      rethrow;
    }
  }
  Future<dynamic> otpApi(dynamic phone) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse("${ApiUrl.sendOtp}mobile=$phone&digit=6&mode=live");
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during otpApi: $e');
      }
      rethrow;
    }
  }
  Future<dynamic> verifyOtpApi(dynamic phone,dynamic otp) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse("${ApiUrl.verifyOtp}mobile=$phone&otp=$otp");
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during verifyOtpApi: $e');
      }
      rethrow;
    }
  }
}
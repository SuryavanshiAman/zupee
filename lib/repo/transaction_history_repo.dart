import 'package:flutter/foundation.dart';
import 'package:zupee/model/transaction_history_model.dart';
import 'package:zupee/res/api_url.dart';
import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class TransactionHistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<TransactionHistoryModel> transactionHistoryApi(dynamic userid,dynamic indexdata) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse("${ApiUrl.transactionHistoryApi}$userid&index=$indexdata");
      return TransactionHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during transactionHistoryApi: $e');
      }
      rethrow;
    }
  }
}
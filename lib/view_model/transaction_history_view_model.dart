import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/repo/transaction_history_repo.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../helper/response/api_response.dart';
import '../model/transaction_history_model.dart';

class TransactionHistoryViewModel with ChangeNotifier {
  final _transactionHistoryRepo = TransactionHistoryRepository();

  ApiResponse<TransactionHistoryModel> transactionHistoryList = ApiResponse.loading();

  setTransactionHistoryList(ApiResponse<TransactionHistoryModel> response) {
    transactionHistoryList = response;
    notifyListeners();
  }

  Future<void> transactionHistoryApi(BuildContext context,dynamic indexData  ) async {
    setTransactionHistoryList(ApiResponse.loading());
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    _transactionHistoryRepo.transactionHistoryApi(userId,indexData).then((value) {
      if (value.status== "200") {
        setTransactionHistoryList(ApiResponse.completed(value));
      } else {
        setTransactionHistoryList(ApiResponse.completed(value));
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      setTransactionHistoryList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/bankdetails_model.dart';
import '../repo/view_bank_details_repo.dart';
import 'user_view_model.dart';

class ViewBankDetailViewModel with ChangeNotifier {
  final _viewBankDetailRepo = ViewBankDetailsRepository();
  ViewBankDetailsModel? _bankDetailResponse;
  ViewBankDetailsModel? get bankDetailResponse => _bankDetailResponse;


  setBankDetailsList(ViewBankDetailsModel response) {
    _bankDetailResponse = response;
    notifyListeners();
  }


  Future<void> viewBankDetailsApi(BuildContext context ) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();

    Map data={
      "userid":userId
    };
    _viewBankDetailRepo.viewBankDetailsApi(data).then((value) {
      if (value["status"] == "200") {
        ViewBankDetailsModel bankDetailViewModel = ViewBankDetailsModel.fromJson(value);
        Provider.of<ViewBankDetailViewModel>(context, listen: false)
            .setBankDetailsList(bankDetailViewModel);

      } else {
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

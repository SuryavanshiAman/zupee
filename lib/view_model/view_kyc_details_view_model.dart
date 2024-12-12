import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/kyc_model.dart';
import 'package:zupee/repo/view_kyc_details_repo.dart';
import 'package:zupee/view_model/user_view_model.dart';

class ViewKycDetailViewModel with ChangeNotifier {
  final _viewKycDetailRepo = ViewKycDetailsRepository();
  KycModel? _kycResponse;
  KycModel? get kycResponse => _kycResponse;

  setBankDetailsList(KycModel response) {
    _kycResponse = response;
    notifyListeners();
  }

  Future<void> viewKycDetailsApi( context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
Map data={
  "userid":userId
};
    _viewKycDetailRepo.viewKycDetailsApi(data).then((value) async{
      if (value.status == 200) {
        setBankDetailsList(value);
      } else {

      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

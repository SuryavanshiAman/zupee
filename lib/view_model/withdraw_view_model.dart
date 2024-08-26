import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/repo/withdraw_repo.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../utils/routes_name.dart';



class WithdrawViewModel with ChangeNotifier {
  final _withdrawRepo = WithdrawRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileViewModel profileViewModel = ProfileViewModel();
  // WithdrawHistoryViewModel withdrawHistoryViewModel =
  // WithdrawHistoryViewModel();
  Future<void> withdrawApi(dynamic amount,context) async {
    setLoading(true);

    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data={
      "userid":userId,
    "account_id":"1",
      "amount":amount
    };
    _withdrawRepo.withdrawApi(data).then((value) {
      if (value['status'] =="200") {
        setLoading(false);
        profileViewModel.getProfileApi(context);
        // withdrawHistoryViewModel.withdrawHistoryApi(context);
        Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
        Utils.flushBarSuccessMessage(value['message'], context,white);
      }
      // else if(value['status'] ==404) {
      //   setLoading(false);
      //   setSelectedIndex(-1);
      //   Utils.showErrorToast(value['message']);
      //   Navigator.pushReplacementNamed(context, RoutesName.profileScreen);
      // }
      // else if(value['status'] ==503) {
      //   setLoading(false);
      //   setSelectedIndex(-1);
      //   Utils.errorToastMessage(value['message']);
      // }
      else{
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.showErrorToast(error.toString());
        print('error: $error');
      }
    });
  }

}
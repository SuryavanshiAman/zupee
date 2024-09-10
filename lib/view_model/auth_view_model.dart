import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../repo/auth_repo.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> authApi(dynamic phone, context) async {
    setLoading(true);
    Map data={
      "mobile_number":phone
    };
    _authRepo.authApi(data).then((value) {
      if (value['status'] == "201") {
        setLoading(false);
        // userPref.saveUser(value['data']['id'].toString());
        sedOtpApi(phone, context);
        Navigator.pushNamed(context, RoutesName.verifyPage,arguments: {
          "phone": phone,
          "userID":value['data']['id'].toString()
        });
        Utils.showSuccessToast(value['message']);
      } else if(value['status'] == "200") {
        setLoading(false);

        sedOtpApi(phone, context);
        Navigator.pushNamed(context, RoutesName.verifyPage,arguments: {
          "phone": phone,
          "userID":value['data']['id'].toString()
        });
        Utils.showSuccessToast(value['message']);
      }
      else {
      setLoading(false);
      Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('registerError: $error');
      }
    });
  }
  final _otpRepo = AuthRepository();



  Future<void> sedOtpApi(dynamic data, context) async {
    setLoading(true);
    _otpRepo.otpApi(data).then((value) {
      if (value['error'] == "200") {
        setLoading(false);
        Utils.showSuccessToast(value['msg']);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['msg']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('otpError: $error');
      }
    });
  }

  Future<void> verifyOtpApi(dynamic phone,dynamic otp,dynamic userID, context) async {
    final userPref = Provider.of<UserViewModel>(context, listen: false);
    setLoading(true);
    print(otp);
    _otpRepo.verifyOtpApi(phone,otp).then((value) {
      if (value['error'] == "200") {
        setLoading(false);
        userPref.saveUser(userID.toString());
        Utils.showSuccessToast(value['msg']);

        Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['msg']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('verifyError: $error');
      }
    });
  }


}
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:zupee/utils/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {
  Future<String?> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.toString());
        print('valueId');
      }
      if (value.toString() == 'null' || value.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.registerScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

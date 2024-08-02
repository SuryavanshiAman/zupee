import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/help_support_model.dart';
import 'package:zupee/repo/help_repo.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../helper/response/api_response.dart';

class HelpViewModel with ChangeNotifier {
  final _helpRepo =HelpRepository();

  ApiResponse<HelpModel> helpList = ApiResponse.loading();

  setHelpList(ApiResponse<HelpModel> response) {
    helpList = response;
    notifyListeners();
  }

  Future<void>helpApi(BuildContext context ) async {
    setHelpList(ApiResponse.loading());
    _helpRepo.helpApi().then((value) {
      if (value.status== "200") {
        setHelpList(ApiResponse.completed(value));
      } else {
        if (kDebugMode) {
          print('value:');
        }
      }
    }).onError((error, stackTrace) {
      setHelpList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

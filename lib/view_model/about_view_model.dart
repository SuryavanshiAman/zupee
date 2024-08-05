import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/about_model.dart';
import 'package:zupee/model/help_support_model.dart';
import 'package:zupee/repo/about_repo.dart';
import 'package:zupee/repo/help_repo.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../helper/response/api_response.dart';

class AboutViewModel with ChangeNotifier {
  final _aboutRepo =AboutRepository();

  ApiResponse<AboutModel> aboutList = ApiResponse.loading();

  setAboutList(ApiResponse<AboutModel> response) {
    aboutList = response;
    notifyListeners();
  }

  Future<void>aboutApi(BuildContext context ) async {
    setAboutList(ApiResponse.loading());
    _aboutRepo.aboutApi().then((value) {

      if (value.status== "200") {
        setAboutList(ApiResponse.completed(value));
      } else {
        if (kDebugMode) {
          print('value:');
        }
      }
    }).onError((error, stackTrace) {
      setAboutList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zupee/model/notification_model.dart';
import 'package:zupee/repo/notification_repo.dart';

import '../helper/response/api_response.dart';
import 'user_view_model.dart';

class NotificationViewModel with ChangeNotifier {
  final _notificationRepo =NotificationRepository();

  ApiResponse<NotificationModel> notificationList = ApiResponse.loading();

  setNotificationList(ApiResponse<NotificationModel> response) {
    notificationList = response;
    notifyListeners();
  }

  Future<void>notificationApi(BuildContext context ,dynamic status) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setNotificationList(ApiResponse.loading());
    _notificationRepo.notificationApi(userId,status).then((value) {
      if (value.status == "200") {
        setNotificationList(ApiResponse.completed(value));
      } else {
        setNotificationList(ApiResponse.completed(value));
        if (kDebugMode) {
          print('value:');
        }

      }
    }).onError((error, stackTrace) {
      setNotificationList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}

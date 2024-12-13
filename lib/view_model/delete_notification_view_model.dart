
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zupee/repo/delete_notification_repo.dart';
import 'package:zupee/res/launcher.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/notification_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';



class DeleteNotificationViewModel with ChangeNotifier {
  final _deleteRepo = DeleteNotificationRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteNotificationApi(dynamic id,context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print(userId);
    print("userId");
    Map data={
      "id":id.toString(),
      "userid":userId,
    };
print("Amankkkk:$data");
    _deleteRepo.deleteNotificationApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Provider.of<NotificationViewModel>(context, listen: false)
            .notificationApi(context,"3");
        Utils.showSuccessToast(value['message']);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
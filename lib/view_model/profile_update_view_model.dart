import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:zupee/repo/profile_update_repo.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

class ProfileUpdateViewModel with ChangeNotifier {
  final _profileUpdateRepo = ProfileUpdateRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileViewModel profileViewModel = ProfileViewModel();

  Future<void> profileUpdateApi( dynamic name,dynamic image, context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print("Name:$name");
    print("Image:$image");
    Map data = {
      "userid":userId,
      "name":name,
      "image": image,

    };
    _profileUpdateRepo.profileUpdateApi(data).then((value) {
      if (value['status'] == "200") {
        setLoading(false);
        Utils.flushBarSuccessMessage(value['message'], context, white);
        profileViewModel.getProfileApi(context);
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
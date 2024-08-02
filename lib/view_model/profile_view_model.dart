import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/profile_model.dart';
import '../repo/profile_repo.dart';
import 'user_view_model.dart';

class ProfileViewModel with ChangeNotifier {
  final _profileRepo = ProfileRepository();
  ProfileModel? _profileResponse;
  ProfileModel? get profileResponse => _profileResponse;
  setProfileData(ProfileModel response) {
    _profileResponse = response;
    notifyListeners();
  }

  Future<void> getProfileApi(BuildContext context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    _profileRepo.getProfileApi(userId).then((value) {
      if (value['status'] == "200") {
        ProfileModel profileModel = ProfileModel.fromJson(value);
        Provider.of<ProfileViewModel>(context, listen: false)
            .setProfileData(profileModel);
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

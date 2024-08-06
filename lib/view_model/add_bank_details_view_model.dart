import 'package:flutter/foundation.dart';
import 'package:zupee/repo/add_bank_details_repo.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/user_view_model.dart';


class AddBankDetailsViewModel with ChangeNotifier {
  final _addBankDetailsRepo = AddBankDetailsRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addBankDetailsApi(
      dynamic name, dynamic accountNo, dynamic bankName,dynamic branchName,dynamic ifsc ,context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "userid": userId,
      "name": name,
      "account_number": accountNo,
      "bank_name": bankName,
      "branch_name": branchName,
      "ifsc_code": ifsc
    };
    _addBankDetailsRepo.addBankDetailsApi(data).then((value) {

      if (value['status'] == "200") {
        Utils.flushBarSuccessMessage(value['message'],context,red);
      } else {
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

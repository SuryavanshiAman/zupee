import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/model/confirm_payment_model.dart';
import 'package:zupee/repo/confirm_payment_repo.dart';
import 'user_view_model.dart';

class ConfirmPaymentViewModel with ChangeNotifier {
  final _confirmPaymentRepo = ConfirmPaymentRepository();
  ConfirmPaymentModel? _confirmPaymentResponse;
  ConfirmPaymentModel? get confirmPaymentResponse => _confirmPaymentResponse;
  setConfirmPaymentData(ConfirmPaymentModel response) {
    _confirmPaymentResponse = response;
    notifyListeners();
  }

  Future<void> confirmPaymentApi(BuildContext context,dynamic tournamentID) async {
    print("mmmmmmmmmmmmmmmmmm");
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data={
      "userid":userId,
      "tournament_id":tournamentID
    };
    print("confirmPaymentApi:$data");
    _confirmPaymentRepo.confirmPaymentApi(data).then((value) {
      if (value['status'] == "200") {
        ConfirmPaymentModel confirmPaymentModel = ConfirmPaymentModel.fromJson(value);
        Provider.of<ConfirmPaymentViewModel>(context, listen: false).setConfirmPaymentData(confirmPaymentModel);
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

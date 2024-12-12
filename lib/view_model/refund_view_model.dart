import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zupee/repo/refund_repo.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';


class RefundViewModel with ChangeNotifier {
  final _refundRepo = RefundRepository();

  bool _loading = false;
  int documentId = 1;
  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileViewModel profileViewModel = ProfileViewModel();
  Future<void> refundApi( context)async{
    final ludoProvider = Provider.of<LudoProvider>(context,listen: false);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "user_id": userId,
      "amount":ludoProvider.entryAmount,
      "tournamentid":ludoProvider.tournamentId
    };
    print("tournament_id:$data");
    _refundRepo.refundApi(data).then((value) async {
      if (value['status'] == 200) {
        print("AAgya data");
        setLoading(false);
        if (!context.mounted) return;
        ludoProvider.removePlayerName(context);
        profileViewModel.getProfileApi(context);
        Navigator.pushNamed(context, RoutesName.bottomNevBar,
            arguments: {"index": 0});
        Utils.showSuccessToast(value['message']);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('joinApi: $error');
      }
    });
  }
}

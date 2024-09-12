import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:zupee/repo/join_contest_repo.dart';
import 'package:zupee/repo/send_result_repo.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/ludo_constant.dart';
import 'package:zupee/view/Game/ludo_player.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import 'firebase_view_model.dart';

class SendResultViewModel with ChangeNotifier {
  final _sendResultRepo = SendResultRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<void> sendResultApi(dynamic tournamentID, dynamic tableId, context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "userid":userId,
      "tournament_id":tableId,
      "game_playing_status":"2",
      "score":"135"
    };
    _sendResultRepo.sendResultApi(data).then((value) async {
      if (value['status'] == 200) {
        print("AAgya data");
        setLoading(false);

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

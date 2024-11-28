import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:zupee/repo/send_chat_repo.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

class SendChatViewModel with ChangeNotifier {
  final _sendChatRepo = SendChatRepository();

  bool _loading = false;
  int documentId = 1;
  bool get loading => _loading;


  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileViewModel profileViewModel = ProfileViewModel();
  Future<void> sendChatApi( dynamic message, context)async{
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "sender_id":userId,
      "message":message
    };
    _sendChatRepo.sendChatApi(data).then((value) async {
      if (value['status'] == "success") {
        print("AAgya data");
        setLoading(false);
      } else {
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('joinApi: $error');
      }
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(String userId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', userId);
    notifyListeners();
    return true;
  }

  Future<String?> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return token;
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
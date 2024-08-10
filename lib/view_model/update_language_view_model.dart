



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateLanguageViewModel with ChangeNotifier{

/// if it is false default language is english and true then hindi
bool _buttonState =false;
bool get buttonState=>_buttonState;

setButtonState(bool value){
  _buttonState=value;
  _saveLanguagePreference(value);
  notifyListeners();
}


  updateLanguage(Locale language) {
    // Locale locale = isHindi ? const Locale('hi', 'IN') : const Locale('en', 'US');
    Locale locale =language;
    Get.updateLocale(locale);
  }

  Future<void> _saveLanguagePreference(bool value) async {
    print("rrrr:$value ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await  prefs.setBool('isHindi', value);
  }


}
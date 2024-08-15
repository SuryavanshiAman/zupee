import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/view_model/services/splash_services.dart';
import 'package:zupee/view_model/update_language_view_model.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  UpdateLanguageViewModel updateLanguageViewModel =UpdateLanguageViewModel();
  @override
  void initState() {
    splashServices.checkAuthentication(context);
    // updateLanguageViewModel.loadSwitchState();
    // updateLanguageViewModel.setHindi(!updateLanguageViewModel.isHindi);
    // // updateLanguageViewModel.updateLanguage(updateLanguageViewModel.isHindi);
    getLanguage();
    super.initState();
  }
getLanguage()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isSelectedLanguage=  prefs.getBool('isHindi');
  // print("langua hai:${updateLanguageViewModel.isDefaultSelectedLanguage}");
  print("ghfh :$isSelectedLanguage");
  if(isSelectedLanguage != null){
    if(isSelectedLanguage==true){
      updateLanguageViewModel.updateLanguage(Locale('hi', 'IN'));
      // updateLanguageViewModel.setButtonState(true);
    }else{
      // updateLanguageViewModel.setButtonState(false);
      updateLanguageViewModel.updateLanguage(Locale('en', 'US'));
    }
  }else{
    updateLanguageViewModel.updateLanguage(Locale('en', 'US'));
  }

}

  final bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: secondary,
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(
                  Assets.imagesZupee,
                ),
                height: height * 0.15,
              ),
              const Text(
                "LUDO ZUPEE",
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w700,color: tertiary),
              )
            ],
          ),
        ),
      ),
    );
  }
}

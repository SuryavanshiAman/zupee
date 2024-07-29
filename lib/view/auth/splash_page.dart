import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/app_constant.dart';

import '../../utils/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SplashServices splashServices = SplashServices();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, RoutesName.registerScreen);
    });

    // Login();
    // splashServices.checkAuthentication(context);
    // final profileViewModel=Provider.of<ProfileViewModel>(context,listen: false);
    // profileViewModel.getProfileApi(context);

    super.initState();
  }

// Login(){
//     print("hii");
//     Future.delayed(Duration(seconds: 3),(){
//       Navigator.pushReplacementNamed(context,RoutesName.loginScreen );
//     });
// }
  bool _visible = true;
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage(
                  Assets.imagesZupee,
                ),
                height: height * 0.15,
              ),
              const Text(
                "ZUPEE",
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w700,color: tertiary),
              )
            ],
          ),
        ),
      ),
    );
  }
}

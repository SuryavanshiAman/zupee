import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/check_network/network_message.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

import '../../generated/assets.dart';
import '../../view_model/update_language_view_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  UpdateLanguageViewModel updateLanguageViewModel =UpdateLanguageViewModel();
  @override
  void initState() {
    super.initState();
    getLanguage();
  }

bool?isSelectedLanguage;
  getLanguage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelectedLanguage =  prefs.getBool('isHindi')??false;
    });
  }

  bool viewItem = false;
  late StreamSubscription<ConnectivityResult> _subscription;
  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).profileResponse?.data;
    final language=Provider.of<UpdateLanguageViewModel>(context);
    final ludoProvider=Provider.of<LudoProvider>(context);
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        // setState(() {
          ludoProvider.setConnection(false);
        // });

      } else {
        // setState(() {
          ludoProvider.setConnection(true);
        // });
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading: Row(
          children: [
             GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.bottomNevBar,
                    arguments: {"index": 0});
                // Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,color: black,size: 30,
              ),
            ),
            Text(
              "Account".tr,
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body:ludoProvider.isConnected?(isSelectedLanguage==null|| profileViewModel==null?const Center(
          child: CircularProgressIndicator()): ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.profileScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 22),
                    height: height * 0.13,
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.06,
                        ),
                        profileViewModel.profilePicture != null
                            ? CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                    profileViewModel.profilePicture.toString()),
                              )
                            : const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(Assets.iconAccount),
                              ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileViewModel.username.toString(),
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              profileViewModel.mobileNumber.toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: labelColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "PROFILE >".tr,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: tertiary,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Text("Choose Language".tr,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: height * 0.02,
                ),

                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        language.setButtonState(!language.buttonState);
                        if(language.buttonState==false){
                          language.updateLanguage(const Locale('en', 'US')  );
                        }
                        else{
                          language.updateLanguage(const Locale('hi', 'IN')  );

                        }
                        getLanguage();

                      },
                      child: Container(
                        height:height*0.04,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: lightBlue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'English',
                              style: TextStyle(
                                  color:labelColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Hindi'.tr,
                              style: const TextStyle(
                                  color:labelColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),

                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left:!isSelectedLanguage!? 0 : width * 0.21,
                      child:!isSelectedLanguage!
                          ? Container(
                        alignment: Alignment.center,
                        height:height*0.04,
                        width: width * 0.18,
                        decoration: BoxDecoration(
                         color: tertiary,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Text(
                          'English',
                          style: TextStyle(
                              color:white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                          : Container(
                        alignment: Alignment.center,
                        height:height*0.04,
                        width: width * 0.18,
                        decoration: BoxDecoration(
                          color: tertiary,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child:  Text(
                          'Hindi'.tr,
                          style: const TextStyle(
                              color:white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ),
                  ],
                ),
                Divider(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.walletScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(
                          Assets.iconWallet,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet Balance".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(profileViewModel.wallet.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: tertiary, size: 16)
                    ],
                  ),
                ),
                Divider(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.kycCScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(
                          Assets.iconKyc,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Complete your KYC".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Text("Verify your identity",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor)),
                          profileViewModel.kycStatus!=0?  Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:profileViewModel.kycStatus==1? orange:green,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Text("Pending"),
                          ):Container(),
                        ],
                      ),

                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: tertiary, size: 16)
                    ],
                  ),
                ),
                Divider(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.bankDetailsScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(
                          Assets.iconKyc,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Details".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text("Add your bank details".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor,
                                  fontSize: 13)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: tertiary, size: 16)
                    ],
                  ),
                ),
                Divider(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesName.helpAndSupportScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(
                          Assets.iconSupport,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Help & Support".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text("Customer support,FAQs & Game related\ninfo".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor,
                                  fontSize: 13)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: tertiary,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesName.responsibleGamingScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(
                          Assets.iconSecure,
                          scale: 3,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Responsible Gaming".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text("Tools to help you play responsible".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor,
                                  fontSize: 13)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          color: tertiary, size: 16)
                    ],
                  ),
                ),
                Divider(
                  height: height * 0.05,
                ),
                viewItem == false
                    ? Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              viewItem = true;
                            });
                          },
                          child: Text(
                            "VIEW MORE OPTIONS".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, color: tertiary),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.about);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: lightBlue,
                                    child: Image.asset(
                                      Assets.iconWallet,
                                      scale: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      color: tertiary, size: 16)
                                ],
                              ),
                            ),
                            Divider(
                              height: height * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                showExitConfirmation(context);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: lightBlue,
                                    child: Image.asset(
                                      Assets.iconLogout,
                                      scale: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Logout".tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded,
                                      color: tertiary, size: 16)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      )): const NetworkErrorScreen(),
    );
  }

  Widget row(
    String imageUrl,
    String heading,
    String subHeading,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: tertiary.withOpacity(0.05),
          child: Image.asset(
            imageUrl,
            scale: 8,
          ),
        ),
        Column(
          children: [
            Text(heading),
            Text(subHeading),
          ],
        ),
        const Icon(Icons.arrow_forward_ios_rounded)
      ],
    );
  }

   showExitConfirmation(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return await showModalBottomSheet(
          elevation: 5,
          backgroundColor: primary,
          shape: const RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          context: context,
          builder: (context) {
            return Container(
              // height: height * 0.55,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0, top: 28),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close)),
                  ),
                  SizedBox(height: height*0.01),
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: lightBlue,
                      child: Image.asset(
                        Assets.iconLogout,
                        scale: 2,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text("Logging out?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight:  FontWeight.w600)),
                  ),
                  SizedBox(height: height * 0.02),
                  const Center(
                    child:
                        Text("Are you sure want to log out of this\naccount?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: labelColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            )),
                  ),
                  SizedBox(height: height * 0.02),
                  Center(
                    child: SizedBox(
                      width: width * 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PopScope(
                            canPop: true,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.34,
                                  vertical: height * 0.02,
                                ),
                              ),
                              onPressed: () {
                                setState(() {

                                  UserViewModel userViewModel = UserViewModel();
                                  userViewModel.remove();
                                  Navigator.of(context, rootNavigator: true).pop();
                                  Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
                                });
                              },
                              child: const Text(
                                "Yes, Logout",
                                style: TextStyle(
                                  color: tertiary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 1, color: tertiary),
                                  // elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.34,
                                      vertical: height * 0.02)),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancle",
                                  style: TextStyle(
                                      color: tertiary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ) ??
        false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../generated/assets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isHindi = false;

  updateLanguage(bool isHindi) {
    Locale locale = isHindi ? const Locale('hi', 'IN') : const Locale('en', 'US');
    Get.updateLocale(locale);
  }
  bool _isSecondPage = false;
  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }
  void _toggleSwitch(bool value) {
    setState(() {
      _isSecondPage = value;
    });
  }
  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSecondPage = prefs.getBool('isSwitchOn') ?? false;
    });
  }

  void _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSwitchOn', value);
  }

  bool viewItem=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading:   Row(
          children: [
            const CustomBackButton(),
            Text("Account".tr,style: const TextStyle(fontSize: 18),),
          ],
        ),
      ),
      body:  ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.profileScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 22),
                    height: height*0.13,
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: width*0.06,),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: secondary,
                          child: Image(image: const AssetImage(Assets.iconAccount),height: height*0.05,),
                        ),
                        SizedBox(width: width*0.04,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("+917458XXXX54",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                            const Text("7458946942",style: TextStyle(fontSize: 13,color: labelColor,fontWeight: FontWeight.w500),),
                            Text("PROFILE >".tr,style: const TextStyle(fontSize: 12,color: tertiary,fontWeight: FontWeight.w500),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                 Text("Choose Language".tr,style: const TextStyle(
                    fontWeight: FontWeight.w600
                )),
                SizedBox(height: height*0.02,),
                SlidingSwitch(
                  value: _isSecondPage,
                  width: width*0.4,
                  // onChanged: _toggleSwitch,
                  height: 45,
                  animationDuration: const Duration(milliseconds: 400),
                  onTap: () {},
                  onDoubleTap: () {},
                  onSwipe: () {},
                  textOff: "English",
                  textOn: "Hindi",
                  colorOn: white,
                  colorOff: white,
                  background:lightBlue,
                  buttonColor: tertiary,
                  inactiveColor: black,
                  // value:false,
                  onChanged: (bool value) {   setState(() {
                    isHindi = value;
                    updateLanguage(isHindi);
                    _toggleSwitch;
                  });
                  _saveSwitchState(value);
                    },
                ),
                Divider(height: height*0.05,),
               InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, RoutesName.walletScreen);
                 },
                 child: Row(
                   children: [
                     CircleAvatar(
                       radius: 25,
                       backgroundColor: lightBlue,
                       child: Image.asset(Assets.iconWallet,scale: 3,),
                     ),
                     SizedBox(width: width*0.03,),
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Wallet Balance".tr,style: const TextStyle(
                           fontWeight: FontWeight.w600
                         ),),
                         const Text("₹10.00",style: TextStyle(
                             fontWeight: FontWeight.w500,
                           color: labelColor
                         )),

                       ],
                     ),
                     const Spacer(),
                     const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
                   ],
                 ),
               ),
                Divider(height: height*0.05,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.kycCScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(Assets.iconKyc,scale: 3,),
                      ),
                      SizedBox(width: width*0.03,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Complete your KYC".tr,style: const TextStyle(
                              fontWeight: FontWeight.w600
                          ),),
                          Text("Verify your identity".tr,style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: labelColor,
                              fontSize: 13
                          )),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
                    ],
                  ),
                ),
                Divider(height: height*0.05,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.helpAndSupportScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(Assets.iconSupport,scale: 3,),
                      ),
                      SizedBox(width: width*0.03,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Help & Support".tr,style: const TextStyle(
                              fontWeight: FontWeight.w600
                          ),),
                          Text("Customer support,FAQs & Game related\ninfo".tr,style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: labelColor,
                              fontSize: 13
                          )),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16,)
                    ],
                  ),
                ),
                Divider(height: height*0.05,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.responsibleGamingScreen);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: lightBlue,
                        child: Image.asset(Assets.iconSecure,scale: 3,),
                      ),
                      SizedBox(width: width*0.03,),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Responsible Gaming".tr,style: const TextStyle(
                              fontWeight: FontWeight.w600
                          ),),
                          Text("Tools to help you play responsible".tr,style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: labelColor,
                            fontSize: 13
                          )),

                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
                    ],
                  ),
                ),
                Divider(height: height*0.05,),
                viewItem==false?  Center(
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        viewItem=true;

                      });

                    },
                    child:  Text("VIEW MORE OPTIONS".tr,style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      color: tertiary
                    ),),
                  ),
                ):
                Container(
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Divider(),
                       Text("Game Alerts".tr,style: const TextStyle(
                          fontWeight: FontWeight.w600
                      )),
                      SizedBox(height: height*0.02,),
                      SlidingSwitch(
                        // value: _isSecondPage,
                        width: width*0.4,
                        // onChanged: _toggleSwitch,
                        height: 45,
                        animationDuration: const Duration(milliseconds: 400),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "OFF",
                        textOn: "ON",
                        colorOn: white,
                        colorOff: white,
                        background:lightBlue,
                        buttonColor: tertiary,
                        inactiveColor: black, value:false, onChanged: (bool value) {  },
                      ),
                      Divider(height: height*0.05,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: lightBlue,
                            child: Image.asset(Assets.iconWallet,scale: 3,),
                          ),
                          SizedBox(width: width*0.03,),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Game Management".tr,style: const TextStyle(
                                  fontWeight: FontWeight.w600
                              ),),
                              Text("Game updates and more".tr,style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: labelColor
                              )),

                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
                        ],
                      ),
                      Divider(height: height*0.05,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.about);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: lightBlue,
                              child: Image.asset(Assets.iconWallet,scale: 3,),
                            ),
                            SizedBox(width: width*0.03,),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("About".tr,style: const TextStyle(
                                    fontWeight: FontWeight.w600
                                ),),
                                // Text("Game updates and more",style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     color: labelColor
                                // )),

                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
                          ],
                        ),
                      ),
                      Divider(height: height*0.05,),
                      InkWell(
                        onTap: (){
                          showExitConfirmation(context);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: lightBlue,
                              child: Image.asset(Assets.iconLogout,scale: 3,),
                            ),
                            SizedBox(width: width*0.03,),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Logout".tr,style: const TextStyle(
                                    fontWeight: FontWeight.w600
                                ),),
                                // Text("Game updates and more",style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     color: labelColor
                                // )),

                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded,color: tertiary,size: 16)
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
      ),
    );
  }
  Widget row(
      String imageUrl,
      String heading,
      String subHeading,
      ){
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: tertiary.withOpacity(0.05),
          child: Image.asset(imageUrl,scale: 8,),
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
  static showExitConfirmation(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return await showModalBottomSheet(
      elevation: 5,
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 28),
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close)),
              ),
              SizedBox(height: height / 30),
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: lightBlue,
                  child: Image.asset(Assets.iconLogout,scale: 2,),
                ),
              ),
              Center(
                child: Text("Logging out?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: height*0.02),
              Center(
                child: Text("Are you sure want to log out of this\naccount?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: labelColor,
                      fontSize: 16,
                    )),
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: Container(
                  width: width * 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // side:
                            // BorderSide(width: 1, color: Colors.white),
                            // elevation: 3,
                              backgroundColor: secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.34,
                                  vertical: height * 0.02)),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: Text("Yes,Logout",
                              style: TextStyle(
                                  color: tertiary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(height: height * 0.03),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(width: 1,color: tertiary),
                              // elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.34,
                                  vertical: height * 0.02)),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text("Cancle",
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

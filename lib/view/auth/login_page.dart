import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/app_constant.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  Color _containerColor = lightGray;
  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateContainerColor);
  }
  void _updateContainerColor() {
    setState(() {
      if (_controller.text.length == 10) {
        _containerColor = secondary;
      } else {
        _containerColor = lightGray;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        leadingWidth: 200,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "     ${AppConstants.appNameTwo}",
              style: TextStyle(
                  color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        // title: const Text(
        //   "     ${AppConstants.appNameTwo}",
        //   style: TextStyle(
        //       color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),
        // ),
        actions: [
          const Text(
            "NEW USER ?",
            style: TextStyle(
                color: tertiary, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            width: width * 0.08,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
             Center(
              child: Text(
                "Sign in".tr,
                style: const TextStyle(
                    color: black, fontWeight: FontWeight.w700, fontSize: 24),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            // Container(
            //   alignment: Alignment.center,
            //   width: width * 0.8,
            //   height: height * 0.08,
            //   decoration: const BoxDecoration(
            //     color: lightGray,
            //     border: Border(bottom: BorderSide(color: tertiary, width: 3)),
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 24.0, left: 15),
            //     child: Row(
            //       children: [
            //         const Text(
            //           "+91",
            //           style: TextStyle(fontSize: 18, color: black),
            //         ),
            //         CustomTextField(
            //           width: width * 0.65,
            //           label: "Enter your phone number",
            //           hintColor: labelColor,
            //           hintSize: 18,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            CustomTextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              label:  "Enter your phone number".tr,
              hintColor: labelColor,
              hintSize: 18,
              height: 70,
              width: width*0.8,
              maxLength: 10,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              // borderRadius: ,
              filled: true,
              borderSide: const BorderSide(color: tertiary,width: 2),
              borderSideFocus: const BorderSide(color: blue),
              fillColor: tertiary.withOpacity(0.2),
              fieldRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)),
              prefix: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("+91",style: TextStyle(color: black, fontSize: 18),),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            CustomContainer(
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
              },
              alignment: Alignment.center,
              height: height * 0.07,
              widths: width * 0.8,
              color: _containerColor,
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              child:  Text(
                "Accept & Continue".tr,
                style: const TextStyle(color: labelColor, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              "OR",
              style: TextStyle(
                color: black,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CustomContainer(
              alignment: Alignment.center,
              height: height * 0.07,
              widths: width * 0.8,
              color: secondary,
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Image.asset(
                      Assets.imagesGoogle,
                      scale: 6,
                    ),
                  ),
                   Text(
                    "Continue with Google".tr,
                    style:
                        const TextStyle(color: tertiary, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 1,
                width: width * 0.9,
                color: labelColor,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            // Divider(color: labelColor,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  children: [
                     TextSpan(
                      text:"RegisterNote".tr,
                        // text:
                        //     'By continuing, I hereby confirm that I am 18 years of age or above and I am not playing from Assam, Telangana, Nagaland, Andhra Pradesh, Meghalaya, Sikkim, Arunachal Pradesh and outside India and I agree to the ',
                        style: const TextStyle(color: labelColor)),
                    TextSpan(
                      text: 'Terms and Conditions'.tr,
                      style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms and Conditions tap
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy'.tr,
                      style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy tap
                        },
                    ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            // Container(
            //   alignment: Alignment.center,
            //   height: height*0.1,
            //   width: width,
            //
            //   decoration: BoxDecoration(
            //     color: appBarColor,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.2),
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: const Offset(0, -1), // changes position of shadow to the top
            //       ),
            //     ],
            //   ),
            //
            //   child: CustomContainer(
            //     alignment: Alignment.center,
            //     height: height*0.07,
            //     widths: width*0.8,
            //     color: lightGray,
            //     borderRadius: const BorderRadius.all(Radius.circular(35)),
            //     child: const Text("Accept & Continue",style: TextStyle(color: labelColor,fontWeight: FontWeight.w500),),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

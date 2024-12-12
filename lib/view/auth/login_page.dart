import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/app_constant.dart';
import 'package:zupee/res/circular_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/auth_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  Color _containerColor = lightGray;
  UserViewModel userViewModel = UserViewModel();
  @override
  void initState() {
    super.initState();
login();
    _controller.addListener(_updateContainerColor);
  }
login()async{
  String? userId = await userViewModel.getUser();
  print(":uuuuu${userId}");
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
    final authApi = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        leadingWidth: width*0.6,
        backgroundColor: appBarColor,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
               Navigator.pushNamed(context, RoutesName.registerScreen);
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
                size: 30,
              ),
            ),
            const Text(
              "     ${AppConstants.appNameTwo}",
              style: TextStyle(
                  color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "NEW USER ?",
              style: TextStyle(
                  color: tertiary, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(
            width: width * 0.08,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            CustomTextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              label: "Enter your phone number".tr,
              hintColor: labelColor,
              hintSize: 18,
              height: 70,
              width: width * 0.8,
              maxLength: 10,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              filled: true,
              borderSide: const BorderSide(color: tertiary, width: 2),
              borderSideFocus: const BorderSide(color: blue),
              fillColor: tertiary.withOpacity(0.2),
              fieldRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              prefix: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "+91",
                  style: TextStyle(color: black, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            authApi.loading==false?    CustomContainer(
              onTap: () {
                if (_controller.text.isEmpty || _controller.text.length <10) {
                  Utils.flushBarErrorMessage(
                      "Please Enter Contact No.", context, white);
                } else {
                  authApi.authApi(_controller.text.toString(),"","","", context);
                }
              },
              alignment: Alignment.center,
              height: height * 0.07,
              widths: width * 0.8,
              color: _containerColor,
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              child: Text(
                "Accept & Continue".tr,
                style: const TextStyle(
                    color: labelColor, fontWeight: FontWeight.w500),
              ),
            ):CircularButton(),
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
                    style: const TextStyle(
                        color: tertiary, fontWeight: FontWeight.w600),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "RegisterNote".tr,
                        style: const TextStyle(color: labelColor)),
                    TextSpan(
                      text: 'Terms and Conditions'.tr,
                      style: const TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
          ],
        ),
      ),
    );
  }
}

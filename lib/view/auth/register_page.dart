
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/app_constant.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
        leading: const Text(
          "     ${AppConstants.appNameTwo}",
          style: TextStyle(
              color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.04,
          ),
           Center(
            child: Text(
              "signup".tr,
              style: const TextStyle(
                  color: black, fontWeight: FontWeight.w700, fontSize: 24),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Center(
            child: Container(
              height: height * 0.045,
              width: width * 0.7,
              decoration:  BoxDecoration(
                  color: lightPurple.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.card_giftcard_outlined),
                  CustomRichText(textSpans: [
                    CustomTextSpan(
                        text: 'Signup to get ₹10 bonus'.tr, textColor: black, fontSize: 18),
                  //   CustomTextSpan(
                  //       text: ' ₹10 bonus', textColor: black, fontSize: 18),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            label:  "Enter your phone number".tr,
            hintColor: labelColor,
            height: 70,
            width: width*0.8,
            maxLength: 10,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          //           controller: _controller,
          //           maxLength: 10,
          //           width: width * 0.65,
          //           label: "Enter your phone number",
          //           keyboardType: TextInputType.number,
          //           hintColor: labelColor,
          //           hintSize: 18,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: height * 0.03,
          ),
          RichText(
              text: TextSpan(
                  text: "Existing User?".tr,
                  style: const TextStyle(
                    color: black,
                    fontSize: 17,
                  ),
                  children: [
                TextSpan(
                  text: 'SIGN IN HERE'.tr,
                  style: const TextStyle(
                      color: tertiary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, RoutesName.loginScreen);
                  },
                ),
              ])),
          SizedBox(
            height: height * 0.03,
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan( text: "RegisterNote".tr,
                style: const TextStyle(fontSize: 12, color: labelColor),
                children: [
              //      TextSpan(
              // text: "RegisterNote".tr,style: TextStyle(color: labelColor)),
                      // text: 'By continuing, I hereby confirm that I am 18 years of age or above and I am not playing from Assam, Telangana, Nagaland, Andhra Pradesh, Meghalaya, Sikkim, Arunachal Pradesh and outside India and I agree to the '=-]
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
                      color:black,
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
          const Spacer(),
          Container(
            alignment: Alignment.center,
            height: height*0.1,
            width: width,

            decoration: BoxDecoration(
              color: appBarColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, -1), // changes position of shadow to the top
                ),
              ],
            ),

            child: InkWell(
              onTap: (){
                if(_controller.text.isEmpty){
                  Utils.flushBarErrorMessage("Please Enter Contact No.", context, white);
                }else{
                  Navigator.pushNamed(context, RoutesName.verifyPage);
                }

              },
              child: CustomContainer(
                alignment: Alignment.center,
                height: height*0.07,
                widths: width*0.8,
                color: _containerColor,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child:  Text("Accept & Continue".tr,style: const TextStyle(color: labelColor,fontWeight: FontWeight.w500),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_pin_field.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../res/app_constant.dart';
import '../../utils/toast.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({
    super.key,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  // ApiController apiController = ApiController();
  List<TextEditingController> otpCon = List.generate(
    6,
        (index) => TextEditingController(),
  );
  int countdown = 30;
  late Timer countdownTimer;

  void startCountdown() {
    setState(() {
      countdown = 30;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        setState(() {
        });
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }
  final TextEditingController _controller = TextEditingController();
  Color _containerColor = lightGray;
  void _updateContainerColor() {
    setState(() {
      if (otpCon.length == 6) {
        _containerColor = secondary;
      } else {
        _containerColor = lightGray;
      }
    });
  }
  @override
  void initState() {
    super.initState();
    startCountdown();
    for (var controller in otpCon) {
      controller.addListener(_updateContainerColor);
    }
    // otpCon.addListener(_updateContainerColor);
    // Future.delayed(Duration.zero, () {
    //   Map<String, dynamic> args =
    //   ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    //   // apiController.sendOtpOnPhone(args['phone'].toString());
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // Map<String, dynamic> arguments =
    // ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // String status = arguments["status"].toString();
    // String phone = arguments["phone"].toString();
    // String otp = arguments["otp"].toString();
    // String userId=arguments['userid'].toString();
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 200,
        backgroundColor: secondary,
        leading: const Text(
          "     ${AppConstants.appNameTwo}",
          style: TextStyle(
              color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),
        ),
      ),
      body: SizedBox(
        // height: heights / 2,
        child: Column(
          children: [
            SizedBox(height: height*0.02,),
            Text(
              'Enter OTP',
              style: TextStyle(
                  fontSize:26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: height*0.01,
            ),
            Text(
              'Enter OTP sent to 7458946942',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            // SizedBox(
            //   height: heights / 35,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "7458946942",
            //       style: TextStyle(
            //           fontSize: heights / 35,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black),
            //     ),
            //     IconButton(onPressed: (){
            //       Navigator.pop(context);
            //     }, icon: Icon(Icons.edit))
            //   ],
            // ),
            SizedBox(
              height: heights / 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Center(
                  child: OtpFieldWidget(
                    pinLength: 6,
                    controllers: otpCon,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
          countdown!=0? CustomRichText(textSpans: [
              CustomTextSpan(text: "Retry in",
              fontSize: 18,
                fontWeight: FontWeight.w400
              ),
              CustomTextSpan(text: "   ${countdown} sec",
                fontSize: 18,
              )
            ]):
         InkWell(
           onTap: (){
             startCountdown();
           },
           child: Container(
              alignment: Alignment.center,
              height: height*0.05,
              width: width*0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: tertiary),
            ),
              child: Text("Resend OTP",style: TextStyle(color:tertiary, fontWeight: FontWeight.w700, ),),



            ),
         ),
            // CustomButton(
            //     width: widths*0.4,
            //     onTap: () {
            //       apiController.verifyOtp(context,phone.toString(), otpCon.map((e) => e.text).join().toString(),userId.toString(),status.toString());
            //       print("👳‍♂️👳‍♂️👳‍♂️");
            //       print(phone.toString());
            //       print(otpCon.map((e) => e.text).join());
            //     },
            //     gradient: const LinearGradient(
            //         colors: [Color(0xff196b19),Color(0xff47992a),],
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter
            //     ),
            //     text: 'Submit'),
            Spacer(),
            Container(
              alignment: Alignment.center,
              height: height*0.1,
              width: width,

              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, -1), // changes position of shadow to the top
                  ),
                ],
              ),

              child: CustomContainer(
                onTap: (){
                  otpCon.map((e) => e.text).join().isEmpty?
                      Utils.flushBarErrorMessage("Please Enter OTP", context, white):
                  Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
                },
                alignment: Alignment.center,
                height: height*0.07,
                widths: width*0.8,
                color: _containerColor,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child: const Text("Continue",style: TextStyle(color: labelColor,fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_pin_field.dart';
import 'package:zupee/res/custom_rich_text.dart';
import '../../res/app_constant.dart';
import '../../res/pinput/pinput.dart';
import '../../utils/toast.dart';
import '../../view_model/auth_view_model.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({
    super.key,
  });

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController otpCon = TextEditingController();

  int countdown = 30;
  late Timer countdownTimer;

  void startCountdown() {
    setState(() {
      countdown = 30;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        setState(() {});
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

  Color _containerColor = lightGray;
  void _updateContainerColor() {
    setState(() {
      if (otpCon.text.length == 6) {
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
      otpCon.addListener(_updateContainerColor);

  }

  @override
  Widget build(BuildContext context) {
    final verifyOtpApi = Provider.of<AuthViewModel>(context);
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String phone = arguments["phone"].toString();

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
            SizedBox(
              height: height * 0.02,
            ),
            const Text(
              'Enter OTP',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Enter OTP sent to $phone',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: height / 30,
            ),
             Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child:Pinput(
                controller: otpCon,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: width*0.11,
                  height: height*0.07,
                  textStyle: const TextStyle(fontSize: 20, color: black),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: labelColor, width: 2),
                    ),
                  ),
                ),
                focusedPinTheme: const PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(fontSize: 20, color: labelColor),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: tertiary, width: 2),
                    ),
                  ),
                ),
              ),

              // Center(
              //     child: OtpFieldWidget(
              //   pinLength: 6,
              //   controllers: otpCon,
              // )),
            ),
            const SizedBox(
              height: 20,
            ),
            countdown != 0
                ? CustomRichText(textSpans: [
                    CustomTextSpan(
                        text: "Retry in",
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    CustomTextSpan(
                      text: "   $countdown sec",
                      fontSize: 18,
                    )
                  ])
                : InkWell(
                    onTap: () {
                      startCountdown();
                      verifyOtpApi.sedOtpApi(phone, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: tertiary),
                      ),
                      child: const Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: tertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              height: height * 0.1,
              width: width,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(
                        0, -1), // changes position of shadow to the top
                  ),
                ],
              ),
              child: CustomContainer(
                onTap: () {
                  otpCon.text.isEmpty
                      ? Utils.flushBarErrorMessage(
                          "Please Enter OTP", context, white)
                      : verifyOtpApi.verifyOtpApi(phone.toString(),
                          otpCon.text, context);
                },
                alignment: Alignment.center,
                height: height * 0.07,
                widths: width * 0.8,
                color: _containerColor,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child: const Text(
                  "Continue",
                  style:
                      TextStyle(color: labelColor, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

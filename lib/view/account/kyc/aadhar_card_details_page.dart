import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../../res/custom_back_button.dart';
import '../../../res/custom_text_field.dart';

class AadharCard extends StatelessWidget {
  const AadharCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 250,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Aadhaar Card Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundColor: black,
                            child: Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          const Text(
                            'Aadhaar Number',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 34.0),
                        child: Text(
                          'Enter 12 digit Aadhaar number to generate\n OTP',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: CustomTextField(
                          // controller: controller,
                          keyboardType: TextInputType.number,
                          // label:  "Enter your phone number".tr,
                          hintColor: labelColor,
                          height: 70,
                          width: width * 0.8,
                          maxLength: 10,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          // borderRadius: ,
                          filled: true,
                          borderSide:
                              const BorderSide(color: tertiary, width: 2),
                          borderSideFocus: const BorderSide(color: blue),
                          fillColor: lightBlue,
                          fieldRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 18),
                        height: height * 0.08,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color: lightGray,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Text(
                          "Generate OTP",
                          style: TextStyle(
                              color: labelColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.panCardScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                // height: height * 0.15,
                // width: width*0.9,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: labelColor,
                          child: Text(
                            '2',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        const Text(
                          'Enter OTP',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 38.0),
                      child: Center(
                          child: Text(
                              'Enter 6 digit OTP sent on you mobile\nnumber registered with your Aadhaar Card')),
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

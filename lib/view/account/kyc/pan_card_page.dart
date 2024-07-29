import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/custom_text_field.dart';

import '../../../res/app_colors.dart';
import '../../../res/custom_back_button.dart';

class PanCardScreen extends StatefulWidget {
  const PanCardScreen({super.key});

  @override
  State<PanCardScreen> createState() => _PanCardScreenState();
}

class _PanCardScreenState extends State<PanCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 210,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "PAN Card Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.02,),
          Center(
            child: Container(

              padding: EdgeInsets.all(18),
              // height: height*0.12,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter PAN Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Enter your 10 digit PAN card number",
                    style: TextStyle(fontSize: 14, color: labelColor),
                  ),
                  SizedBox(height: height*0.03,),
                  CustomTextField(
                    // controller: controller,
                    keyboardType: TextInputType.number,
                    // label:  "Enter your phone number".tr,
                    hintColor: labelColor,
                    height: 70,
                    width: width*0.8,
                    maxLength: 10,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    // borderRadius: ,
                    filled: true,
                    borderSide: const BorderSide(color: tertiary,width: 2),
                    borderSideFocus: const BorderSide(color: blue),
                    fillColor: lightBlue,
                    fieldRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    // prefix: const Padding(
                    //   padding: EdgeInsets.all(18.0),
                    //   child: Text("+91",style: TextStyle(color: black, fontSize: 18),),
                    // ),
                  ),
                  SizedBox(height: height*0.02,),
                  CustomTextField(
                    // controller: controller,
                    keyboardType: TextInputType.number,
                    label:  "Date of Birth (DD/MM/YYY)".tr,
                    hintColor: labelColor,
                    height: 70,
                    width: width*0.8,
                    maxLength: 10,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    // borderRadius: ,
                    filled: true,
                    borderSide: const BorderSide(color: tertiary,width: 2),
                    borderSideFocus: const BorderSide(color: blue),
                    fillColor: lightBlue,
                    fieldRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    suffix: Icon(Icons.calendar_today_outlined),
                    // prefix: const Padding(
                    //   padding: EdgeInsets.all(18.0),
                    //   child: Text("+91",style: TextStyle(color: black, fontSize: 18),),
                    // ),
                  ),
                  SizedBox(height: height*0.03,),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 18),
                    height: height*0.08,
                    width: width*0.9,
                    decoration: BoxDecoration(
                      color:lightGray,
                      // border: Border.all(color: lightGray),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child:Text(
"SUBMIT",                      style: TextStyle(color: labelColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

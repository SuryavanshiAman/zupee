import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/toast.dart';

import '../../view_model/deposit_view_model.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController amountCon = TextEditingController();
  int _currentAmount = 0;
  void _updateAmount(int amount) {
    setState(() {
      _currentAmount += amount;
      amountCon.text = _currentAmount.toString();
    });
  }
  Color _containerColor = lightGray;
  @override
  void initState() {
    super.initState();
    amountCon.addListener(_updateContainerColor);
  }
  void _updateContainerColor() {
    setState(() {
      if (int.parse(amountCon.text )==int.parse(_currentAmount.toString())) {
        _containerColor = secondary;
      } else {
        _containerColor = lightGray;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final depositViewModel = Provider.of<DepositViewModel>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading:  Row(
          children: [
            const CustomBackButton(),
            Text(
              "Add Money".tr,
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  height: height * 0.3,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Enter Amount".tr,style: const TextStyle(fontSize: 16),),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CustomTextField(
                        controller: amountCon,
                        keyboardType: TextInputType.number,
                        label: "Enter amount here".tr,
                        hintColor: labelColor,
                        height: 70,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        // borderRadius: ,
                         filled: true,
                        borderSide: const BorderSide(color: blue),
                        borderSideFocus: const BorderSide(color: blue),
                        fillColor: tertiary.withOpacity(0.2),
                        fieldRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        prefix: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("₹",style: TextStyle(color: black, fontSize: 18),),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAmountContainer(100),
                          _buildAmountContainer(50),
                          _buildAmountContainer(10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0,top: 18),
                child: CustomRichText(textSpans: [
                  CustomTextSpan(text: "Code NEW2 Applied.".tr,
                  fontSize: 18
                  ),
                  CustomTextSpan(text: "REMOVE".tr,
                      fontSize: 18,
                    textColor: tertiary
                  )
                ]),
              ),
               Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Get cashback on deposit above ₹1".tr,style: const TextStyle(
                  fontSize: 16,
                  color: labelColor
                ),),
              ),

            ],
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

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                  onTap: (){
                    if (amountCon.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please Enter the Amount".tr, context,white);
                    } else if (int.parse(amountCon.text) < 100) {
                      Utils.flushBarErrorMessage(
                          "Please Enter the Amount at least ₹100".tr,
                          context,white);
                    } else {
                      depositViewModel.depositApi(amountCon.text, context);
                    }
                  },
                  alignment: Alignment.center,
                  height: height*0.07,
                  widths: width*0.8,
                  color: _containerColor,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child:  Text("Add Money".tr,style: const TextStyle(color: labelColor,fontWeight: FontWeight.w500),),
                ),
                 Text("100% Secure Payments".tr,style: const TextStyle(color: labelColor),)
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildAmountContainer(int amount) {
    return GestureDetector(
      onTap: () => _updateAmount(amount),
      child: Container(
        width: width*0.23,
        height: height*0.055,
        // margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: black),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        // color: Colors.blue,
        child: Center(
          child: Text(
            '+ ₹$amount',
            style: const TextStyle(color: black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}





import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';

class TermsAndConditionsBottomSheet extends StatelessWidget {
  const TermsAndConditionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Terms & Conditions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Expanded(
            child: SingleChildScrollView(
              child: Text(
                "By clicking on 'I Accept', I agree that I have read, understood, and accepted the Privacy Policy, Terms & Conditions and Consent Declaration and hereby authorize ZUPEE to receive my demographic information for conducting KYC.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.aadharCard);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 18),
                  height: height*0.07,
                  width: width*0.9,
                  decoration: BoxDecoration(
                    color:secondary,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child:const Text(
                    'I Accept',
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height:height*0.02),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 18),
                height: height*0.07,
                width: width*0.9,
                decoration: BoxDecoration(
                  color:lightGray,
                  // border: Border.all(color: lightGray),
                  borderRadius: BorderRadius.circular(35),
                ),
                child:const Text(
                  'Decline',
                  style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
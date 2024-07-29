import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../../res/custom_back_button.dart';


class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 250,
        leading:  Row(
          children: [
            const CustomBackButton(),
            Text("Complete Your KYC",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select document type for KYC verification',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
           InkWell(
             onTap: (){
               showModalBottomSheet(
                 context: context,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                 ),
                 builder: (BuildContext context) {
                   return TermsAndConditionsBottomSheet();
                 },
               );
             },
             child: Container(
               padding: EdgeInsets.all(18),
               height: height*0.12,
               width: width*0.9,
               decoration: BoxDecoration(
                 color:white,
                 borderRadius: BorderRadius.circular(12),
               ),
               child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 // mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Text(
                             'Aadhaar Card',
                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                           ),
                           SizedBox(width: width*0.02,),
                           Container(
                             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                             decoration: BoxDecoration(
                               color: blue,
                               borderRadius: BorderRadius.circular(8),
                             ),
                             child: const Text(
                               'Recommended',
                               style: TextStyle(color: Colors.white),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: height*0.01,),
                       Text(
                         'OTP based and within 30 seconds',
                         style: TextStyle(fontSize: 14,),
                       ),
                     ],
                   ),
                   Spacer(),
                   Icon(Icons.arrow_forward_ios_sharp,size: 20,)


                 ],
               ),
             ),
           ),
            const SizedBox(height: 8),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.panCardScreen);
              },
              child: Container(
                padding: EdgeInsets.all(18),
                height: height*0.12,
                width: width*0.9,
                decoration: BoxDecoration(
                  color:white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Methods',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                        Text('PAN Card'),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_sharp,size: 20,),
                      ],
                    )

                  ],
                ),
              ),
            ),
             SizedBox(height: height*0.03),
            // const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green[100],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.money, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Get ₹ 10 on completing KYC.'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 18),
              height: height*0.08,
              width: width*0.9,
              decoration: BoxDecoration(
                color:lightBlue,
                border: Border.all(color: lightGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Text(
                'User under 18 years of age (as per the KYC document) will be blocked immediately.',
                style: TextStyle(color: black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TermsAndConditionsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "By clicking on 'I Accept', I agree that I have read, understood, and accepted the Privacy Policy, Terms & Conditions and Consent Declaration and hereby authorize ZUPEE to receive my demographic information for conducting KYC.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.aadharCard);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 18),
                  height: height*0.07,
                  width: width*0.9,
                  decoration: BoxDecoration(
                    color:secondary,
                    // border: Border.all(color: lightGray),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child:Text(
                    'I Accept',
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height:height*0.02),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 18),
                height: height*0.07,
                width: width*0.9,
                decoration: BoxDecoration(
                  color:lightGray,
                  // border: Border.all(color: lightGray),
                  borderRadius: BorderRadius.circular(35),
                ),
                child:Text(
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
import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../../res/custom_back_button.dart';
import '../../bottomsheet/kyc_bottomsheet.dart';


class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 250,
        leading:  const Row(
          children: [
            CustomBackButton(),
            Text("Complete Your KYC",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
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
                 shape: const RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                 ),
                 builder: (BuildContext context) {
                   return const TermsAndConditionsBottomSheet();
                 },
               );
             },
             child: Container(
               padding: const EdgeInsets.all(18),
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
                           const Text(
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
                       const Text(
                         'OTP based and within 30 seconds',
                         style: TextStyle(fontSize: 14,),
                       ),
                     ],
                   ),
                   const Spacer(),
                   const Icon(Icons.arrow_forward_ios_sharp,size: 20,)


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
                padding: const EdgeInsets.all(18),
                height: height*0.12,
                width: width*0.9,
                decoration: BoxDecoration(
                  color:white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Other Methods',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height*0.02,),
                    const Row(
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
              padding: const EdgeInsets.only(left: 18),
              height: height*0.08,
              width: width*0.9,
              decoration: BoxDecoration(
                color:lightBlue,
                border: Border.all(color: lightGray),
                borderRadius: BorderRadius.circular(12),
              ),
              child:const Text(
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

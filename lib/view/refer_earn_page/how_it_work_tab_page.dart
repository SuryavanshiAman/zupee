import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/clipBoardPage.dart';

import '../../generated/assets.dart';
import '../../res/app_colors.dart';

class HowItWorkTabScreen extends StatefulWidget {
  const HowItWorkTabScreen({super.key});

  @override
  State<HowItWorkTabScreen> createState() => _HowItWorkTabScreenState();
}

class _HowItWorkTabScreenState extends State<HowItWorkTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*0.13,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width*0.4,
                    // color: Colors.red,
                    child: Text(
                      '${"Share. Get Paid.".tr}\n${"Repeat Refer & earn".tr} \n${"upto".tr}₹100'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: height*0.13,
                    width: width*0.35,
                    decoration: const BoxDecoration(
                      // color: Colors.red,
                      image: DecorationImage(image: AssetImage(Assets.imagesCelebration),fit: BoxFit.fill)
                    ),
                    // child: Text(
                    //   'Share. Get Paid.\n Repeat Refer & earn \nupto ₹100',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: height*0.35,

            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share your code'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '0498WTY6NN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                copyToClipboard(
                                    '0498WTY6NN',
                                    context);
                                // Handle copy code
                              },
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           CircleAvatar(
                             backgroundColor: green,
                             child: Image.asset(Assets.imagesWhatsapp,scale: 3,),
                           ),
                            SizedBox(width: width*0.03,),
                            const CircleAvatar(
                              backgroundImage: AssetImage(Assets.imagesInstagram),
                            ),
                            SizedBox(width: width*0.03,),
                            const CircleAvatar(
                              backgroundImage: AssetImage(Assets.imagesFacebook),
                            ),
                            SizedBox(width: width*0.03,),
                            InkWell(
                              onTap: (){
                                Share.share('Hi, dost\nZupee hai mera favourite gaming app !! Yahan per Khelo aur Jeeto cash daily !! \n'
                                    'Abhi download karo aur pao ₹10 aur saath hi deposit karne par 25% cashback .Mera code: 0498WTY6NN');
                              },
                              child: const CircleAvatar(
                                // backgroundColor: green,
                                child: Icon(Icons.share),
                              ),
                            ),
                            //
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                          child: Icon(Icons.wallet)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Earn on deposit'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Get upto ₹100 on friend\'s deposit....'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          Padding(
            padding:  const EdgeInsets.all(16.0),
            child: Text(
              "DISCLAIMER".tr,
              // 'DISCLAIMER\n1. On change of Referral Benefits policy or any change in referral benefit payouts, all referral payouts for new referrals will be in accordance with the new policy\n2. If your friend removes the referral code on first deposit, referral deposit benefit will not be given\n3. On reaching a maximum number of allowed referrals, the referral payout of users will be changed. This will be explicitly informed to users who breach the limit',
              style: const TextStyle(
                fontSize: 12,
                color: labelColor,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

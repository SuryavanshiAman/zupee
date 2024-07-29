import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/utils/routes_name.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading:  Row(
          children: [
            const CustomBackButton(),
            Text("Wallet".tr,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.03,),
          Center(
            child: Container(
              padding: const EdgeInsets.all(18),
              height: height*0.65,
              width: width*0.9,

              decoration: const BoxDecoration(
                  color: white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                children: [
                  SizedBox(height: height*0.01,),
                  CustomRichText(textSpans: [
                    CustomTextSpan(text: "Total Balance".tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                    CustomTextSpan(text: "    ⓘ",
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ]),
                  const Text("₹10",style: TextStyle(
                    fontSize: 36,fontWeight: FontWeight.w700
                  ),),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Deposits".tr,style: const TextStyle(
                              fontSize: 16,fontWeight: FontWeight.w400,
                            color: labelColor
                          ),),
                          const Text("₹0",style: TextStyle(
                              fontSize: 30,fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.depositScreen);
                        },
                        child: CustomContainer(
                          height: height*0.06,
                          widths: width*0.35,
                          color: green,
                          borderRadius:  const BorderRadius.all(Radius.circular(25),
                        ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add,color: white,),
                              Text("Add Cash".tr,style: const TextStyle(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),)
                            ],
                          )),
                      )
                    ],
                  ),
                   Divider(
                    height: height*0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Winnings".tr,style: const TextStyle(
                              fontSize: 16,fontWeight: FontWeight.w400,
                              color: labelColor
                          ),),
                          const Text("₹0",style: TextStyle(
                              fontSize: 30,fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                      CustomContainer(
                        onTap: (){
                          // showDialog(context: context, builder: builder)
                          Navigator.pushNamed(context, RoutesName.withdrawScreen);
                        },
                          height: height*0.06,
                          widths: width*0.35,
                          color: secondary,
                          borderRadius:  const BorderRadius.all(Radius.circular(25),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_downward,color: tertiary,),
                              Text("Withdraw".tr,style: const TextStyle(
                                  color: tertiary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),)
                            ],
                          ))
                    ],
                  ),
                  Divider(
                    height: height*0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Cashback Reward".tr,style: const TextStyle(
                          fontSize: 16,fontWeight: FontWeight.w400,
                          color: labelColor
                      ),),
                      const Text("₹0",style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.w500
                      ),),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.pushNamed(context, RoutesName.cashbackDetailsScreen);
                            },
                            child:  Text("CASHBACK DETAILS".tr,style: const TextStyle(
                                // color: tertiary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          SizedBox(width: width*0.01,),
                          const Icon(Icons.arrow_forward_ios_rounded,size: 12,),

                        ],
                      )
                    ],
                  ),
                  Divider(
                    height: height*0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Bonus Reward".tr,style: const TextStyle(
                          fontSize: 16,fontWeight: FontWeight.w400,
                          color: labelColor
                      ),),
                      const Text("₹0",style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.w500
                      ),),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.pushNamed(context, RoutesName.bonusDetailsScreen);
                            },
                            child:  Text("BONUS DETAILS".tr,style: const TextStyle(
                              // color: tertiary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                          SizedBox(width: width*0.01,),
                          const Icon(Icons.arrow_forward_ios_rounded,size: 12,),

                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomContainer(
              padding: const EdgeInsets.all(15),
              height: height*0.1,
              widths: width,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: white,
              child:  InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.transactionScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Transaction History".tr,style: const TextStyle(
                      // color: tertiary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: width*0.01,),
                    const Icon(Icons.arrow_forward_ios_rounded,size: 22,),

                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

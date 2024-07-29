import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/custom_container.dart';

import '../../res/app_colors.dart';
import '../../res/custom_back_button.dart';

class CashbackDetailsScreen extends StatefulWidget {
  const CashbackDetailsScreen({super.key});

  @override
  State<CashbackDetailsScreen> createState() => _CashbackDetailsScreenState();
}

class _CashbackDetailsScreenState extends State<CashbackDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: appBarColor,
      appBar:  AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading:  const Row(
          children: [
            CustomBackButton(),
            Text("Cashback Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
          body:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount",style:TextStyle(color: labelColor)),
                    Text("Expiry Date",style:TextStyle(color: labelColor)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: const Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                    itemCount:6,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: height*0.06,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₹5.16",style:TextStyle(color: black,fontWeight: FontWeight.w600)),
                              Text("16-08-2024",style:TextStyle(color: black,fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 12,right: 12),
                width: width,
                height: height*0.08,
                color: lightGray,
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    Text("This screen shows expiring cashback only.View\n transaction history for all cashback transactions.")
                  ],
                ),
              )
            ],
          ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';

class MyReferralsTabScreen extends StatefulWidget {
  const MyReferralsTabScreen({super.key});

  @override
  State<MyReferralsTabScreen> createState() => _MyReferralsTabScreenState();
}

class _MyReferralsTabScreenState extends State<MyReferralsTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Container(
            height: height*0.12,
            width:width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              children: [
                SizedBox(height: height*0.02,),
                Text("₹0",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 26),),
                Text("Earned through referrals",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

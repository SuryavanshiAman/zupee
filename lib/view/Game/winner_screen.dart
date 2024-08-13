import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';

import '../../generated/assets.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.ludoWinnerBg), fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(height: height*0.1,),
            Container(
              height: height * 0.37,
              width: width * 0.9,
              decoration: BoxDecoration(
                  color: blue.withOpacity(0.4), borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                      height: height * 0.04,
                      width: width * 0.18,
                      decoration: BoxDecoration(
                          color: black.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
                      child: const Text("Winner",style: TextStyle(color: white,fontWeight: FontWeight.w500),)),
                  const Text("You have won the match!",style: TextStyle(color: white,fontWeight: FontWeight.w500),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

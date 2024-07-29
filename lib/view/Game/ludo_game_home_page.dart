import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';

class LudoHomeScreen extends StatefulWidget {
  const LudoHomeScreen({super.key});

  @override
  State<LudoHomeScreen> createState() => _LudoHomeScreenState();
}

class _LudoHomeScreenState extends State<LudoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.imagesLudoHomeBg),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              Container(
                height: height*0.06,

                  child: Image(image: AssetImage(Assets.ludoPrizePool))),
              Center(
                child: Container(
                  width: width,
                  height: height*0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.ludoLudoBoard),fit: BoxFit.fill)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.ludoBoardTwo))
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

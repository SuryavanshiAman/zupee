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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesLudoHomeBg),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Container(
                      height: height * 0.07,
                      width: width * 0.45,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoPrizePool),
                              fit: BoxFit.fill)),
                      child: const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Prize Pool",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11),
                            ),
                          ),
                          Text(
                            "₹20",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: width * 0.14,
                  ),
                  SizedBox(
                      height: height * 0.04,
                      child:
                          const Image(image: AssetImage(Assets.ludoSetting))),
                  SizedBox(
                    width: width * 0.03,
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.03,
                      width: width * 0.23,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoLabelSection),
                              fit: BoxFit.fill)),
                      child: const Text("Aman",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))),
                  Image(
                    image: const AssetImage(
                      Assets.ludoInfo,
                    ),
                    height: height * 0.03,
                    width: width * 0.08,
                    fit: BoxFit.fill,
                  ),
                  const Spacer(),
                  Container(
                      child: Image(
                    image: const AssetImage(
                      Assets.ludoInfo,
                    ),
                    height: height * 0.03,
                    width: width * 0.08,
                    fit: BoxFit.fill,
                  )),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.03,
                      width: width * 0.23,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoLabelSectionTwo),
                              fit: BoxFit.fill)),
                      child: const Text("Shweta",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: height * 0.07,
                        width: width * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoProfileSection))),
                        child: Image(
                          image: const AssetImage(
                            Assets.ludoUser,
                          ),
                          height: height * 0.03,
                          width: width * 0.23,
                          fit: BoxFit.fill,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: height * 0.08,
                        width: width * 0.19,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoDiceSectionOne),
                                fit: BoxFit.fill)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image(
                            image: const AssetImage(
                              Assets.ludoDice,
                            ),
                            height: height * 0.06,
                            width: width * 0.17,
                          ),
                        )),
                    const Spacer(),
                    Container(
                        alignment: Alignment.center,
                        height: height * 0.08,
                        width: width * 0.19,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoDiceSectionTwo),
                                fit: BoxFit.fill)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image(
                            image: const AssetImage(
                              Assets.ludoDice,
                            ),
                            height: height * 0.06,
                            width: width * 0.17,
                          ),
                        )),
                    Container(
                        height: height * 0.07,
                        width: width * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoProfileSection))),
                        child: Image(
                          image: const AssetImage(
                            Assets.ludoUser,
                          ),
                          height: height * 0.03,
                          width: width * 0.23,
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: width,
                  height: height * 0.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoLudoBoard),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoBoardTwo))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: height * 0.07,
                        width: width * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoProfileSection))),
                        child: Image(
                          image: const AssetImage(
                            Assets.ludoUser,
                          ),
                          height: height * 0.03,
                          width: width * 0.23,
                          fit: BoxFit.fill,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: height * 0.08,
                        width: width * 0.19,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoDiceSectionOne),
                                fit: BoxFit.fill)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image(
                            image: const AssetImage(
                              Assets.ludoDice,
                            ),
                            height: height * 0.06,
                            width: width * 0.17,
                          ),
                        )),
                    const Spacer(),
                    Container(
                        alignment: Alignment.center,
                        height: height * 0.08,
                        width: width * 0.19,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoDiceSectionTwo),
                                fit: BoxFit.fill)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image(
                            image: const AssetImage(
                              Assets.ludoDice,
                            ),
                            height: height * 0.06,
                            width: width * 0.17,
                          ),
                        )),
                    Container(
                        height: height * 0.07,
                        width: width * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.ludoProfileSection))),
                        child: Image(
                          image: const AssetImage(
                            Assets.ludoUser,
                          ),
                          height: height * 0.03,
                          width: width * 0.23,
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.03,
                      width: width * 0.23,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoLabelSection),
                              fit: BoxFit.fill)),
                      child: const Text("Anurag",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))),
                  Image(
                    image: const AssetImage(
                      Assets.ludoInfo,
                    ),
                    height: height * 0.03,
                    width: width * 0.08,
                    fit: BoxFit.fill,
                  ),
                  const Spacer(),
                  Image(
                    image: const AssetImage(
                      Assets.ludoInfo,
                    ),
                    height: height * 0.03,
                    width: width * 0.08,
                    fit: BoxFit.fill,
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: height * 0.03,
                      width: width * 0.23,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.ludoLabelSectionTwo),
                              fit: BoxFit.fill)),
                      child: const Text("Tanisha",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

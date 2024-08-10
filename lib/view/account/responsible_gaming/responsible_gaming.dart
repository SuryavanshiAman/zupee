import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/utils/routes_name.dart';

class ImportantPoint {
  String image;
  String title;
  String subTitle;

  ImportantPoint(
      {required this.image, required this.title, required this.subTitle});
}

class ResponsibleGamingScreen extends StatefulWidget {
  const ResponsibleGamingScreen({super.key});

  @override
  _ResponsibleGamingScreenState createState() => _ResponsibleGamingScreenState();
}

class _ResponsibleGamingScreenState extends State<ResponsibleGamingScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);

  void _handleScroll() {
    setState(() {
      if (_scrollController.position.pixels > 200) {
        _showTitle = false;
      } else {
        _showTitle = true;
      }
    });
  }

  List<ImportantPoint> point = [
    ImportantPoint(
        image: Assets.imagesFewGame,
        title: "Lost a few games?",
        subTitle: "Takes a break before you\njump into another one"),
    ImportantPoint(
        image: Assets.imagesBorrowed,
        title: "Don't play with\nborrowed money",
        subTitle: "Always play with your\nown disposable money"),
    ImportantPoint(
        image: Assets.imagesStressed,
        title: "Stressed?",
        subTitle:
            "Don't play a game.Instead\ntake apause and play\nwith a calm state of mind"),
    ImportantPoint(
        image: Assets.imagesPlayToEarn,
        title: "Don't play to earn?",
        subTitle:
            "Play for entertainment\nand work on your skills,rewards will follow"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: !_showTitle ? black : black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(
              !_showTitle ? "Responsible Gaming".tr : "",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: black),
            ),
            backgroundColor: !_showTitle ? white : Colors.white,
            pinned: true,
            snap: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 105, right: 160),
              title: Text(
                "Responsible Gaming".tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              background: Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Hey! Let's make Zupee a safe & rewarding place together. We got your back"
                            .tr,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 28.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          Assets.imagesResponsible,
                        ), // Replace with your image asset
                        radius: 55.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18),
                  child: Text(
                    "Always remember".tr,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "A few things to keep in mind".tr,
                    style: const TextStyle(
                        fontSize: 14,
                        color: labelColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: SizedBox(
                    width: width,
                    height: height * 0.18,
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: point.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width * 0.8,
                              height: height * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  image: AssetImage(point[index].image),
                                  alignment: Alignment.topLeft,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 108.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      point[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      point[index].subTitle,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  width: width,
                  color: lightBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last risk assessment score".tr,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Taken on 26th July 2024 at 03:10 PM".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            color: labelColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width,
                        height: height * 0.3,
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.07,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(Assets.imagesSugestion),
                                      fit: BoxFit.fill)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: width * 0.5,
                                  // color: Colors.red,
                                  child: Text(
                                    "You need to start playing responsible.Don't worry,we are here to help you.Try our Loss Management tool"
                                        .tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Image(
                                  image: const AssetImage(Assets.imagesRisk),
                                  height: height * 0.13,
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 18),
                              height: height * 0.06,
                              width: width * 0.75,
                              decoration: BoxDecoration(
                                color: secondary,
                                // border: Border.all(color: lightGray),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Text(
                                "Take Quiz Again".tr,
                                style: const TextStyle(
                                    color: tertiary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18),
                  child: Text(
                    "Want to limit your gaming time?".tr,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "We have got some tools for you!".tr,
                    style: const TextStyle(
                        fontSize: 14,
                        color: labelColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: width,
                    height: height * 0.25,
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundColor: lightBlue,
                                child: Image(
                                  image:
                                      const AssetImage(Assets.imagesDownword),
                                  height: height * 0.07,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loss Management".tr,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                SizedBox(
                                  width: width * 0.5,
                                  // color: Colors.red,
                                  child: Text(
                                    "Use Lose Management to automatically restrict access to games for a some period"
                                        .tr,
                                    style: const TextStyle(
                                        fontSize: 12, color: labelColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.lossManagementScreen);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 18),
                            height: height * 0.06,
                            width: width * 0.75,
                            decoration: BoxDecoration(
                              color: secondary,
                              // border: Border.all(color: lightGray),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              "Try this tool".tr,
                              style: const TextStyle(
                                  color: tertiary, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18),
                  child: Text(
                    "FAQs".tr,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "More help here".tr,
                    style: const TextStyle(
                        fontSize: 14,
                        color: labelColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        // const HelpRow(label:"Game Related" ,),
                        expension("What is Responsible Gaming?", [
                          const ListTile(
                            title: Text(
                                "Responsible gaming is a set of guidelines,timely interventions and tools we've created for you so can learn to manage and control your gaming behaviour.",
                                style: TextStyle(color: black, fontSize: 14)),
                          ),
                        ]),
                        Divider(
                          height: height * 0.02,
                        ),
                        expension(
                            "How does the Risk Assessment Quiz help me? Can I take the quiz multiple times?",
                            [
                              const ListTile(
                                title: Text(
                                    "The quiz helps you to assess your risk level on the basis of which certain tools and interventions will be suggested for you.This will help you regulate your gaming behaviour.You can take the quiz up to 5 times a day. ",
                                    style:
                                        TextStyle(color: black, fontSize: 14)),
                              ),
                            ]),
                        // const HelpRow(label:"Wallet & Payment" ,),
                        Divider(
                          height: height * 0.02,
                        ),
                        expension("What is the Loss Management tool?", [
                          const ListTile(
                            title: Text(
                                "The Loss Management tool allows you to set up loss limits calculated for a specific period.For example,if your losses exceed the limits that you have set for yourself,your access to the paid games will be restricted for a limited period of time.Both loss calculation and restriction time periods will be decided by you.",
                                style: TextStyle(color: black, fontSize: 14)),
                            trailing: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 14,
                            ),
                          ),
                        ]),

                        expension(
                            "Can I edit or delete the loss Management limits?",
                            [
                              const ListTile(
                                title: Text(
                                    "Yes, you can edit or delete the loss Management limits up to 5 times a day.",
                                    style:
                                        TextStyle(color: black, fontSize: 14)),
                              ),
                            ]),
                        Divider(
                          height: height * 0.02,
                        ),
                        expension(
                            "What will happen if the Loss Management limits are crossed?",
                            [
                              const ListTile(
                                title: Text(
                                    "If you cross the Loss Management limits that you've set, your access to paid games will be restricted for a specific period of time set by you.In case you want to resume your gameplays before the restriction period ends, the Loss Management limits can be deleted.",
                                    style:
                                        TextStyle(color: black, fontSize: 14)),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: CustomRichText(textSpans: [
                    CustomTextSpan(
                        text: 'To know more,read our'.tr, fontSize: 14),
                    CustomTextSpan(
                        text: ' Responsible Gaming Policy'.tr,
                        fontSize: 14,
                        textColor: tertiary),
                  ]),
                ),
                SizedBox(
                  height: height * 0.02,
                )
              ])),
        ],
      ),
    );
  }

  bool _customTileExpanded = false;
  Widget expension(
    String title,
    List<Widget> expansionChildren,
  ) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(
              color: black, fontWeight: FontWeight.w500, fontSize: 16)),
      trailing: Icon(
        _customTileExpanded
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down,
      ),
      children: expansionChildren,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}

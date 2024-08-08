import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/account/account.dart';
import 'package:zupee/view/refer_earn_page/refer_earn_page.dart';

import 'adda/adda_page.dart';
import 'home/home_page.dart';

class BottomNevBar extends StatefulWidget {
  const BottomNevBar({super.key});

  @override
  State<BottomNevBar> createState() => _BottomNevBarState();
}

class _BottomNevBarState extends State<BottomNevBar> {
  final pages = [
    const HomeScreen(),
    const ReferAndEarnScreen(),
    const AddaScreen(),
    const AccountScreen(),
  ];

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        pageIndex = (arguments['index'] ?? pageIndex);
      });
    });
  }

  Future<bool> _onWillPop() async {
    if (pageIndex > 0) {
      setState(() {
        pageIndex = 0;
      });
      return false;
    } else {
      return await Utils.showExitConfirmation(context) ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:(v) {
        _onWillPop();
      },
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }
  int bottom = 0;
  Widget buildMyNavBar(BuildContext context) {
    return Container(
      height: height*0.085,
      decoration: const BoxDecoration(
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                pageIndex = 0;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                    pageIndex == 0
                        ? Image.asset(
                            Assets.iconHome,
                            height: 32,
                          )
                        : Image.asset(
                            Assets.iconHomeTwo,
                            height: 30,
                ),
                pageIndex == 0
                    ?  Text(
                        'Home'.tr,
                        style: TextStyle(
                            fontSize: 11,
                            color: tertiary,
                            fontWeight: FontWeight.bold),
                      )
                    :  Text(
                        'Home'.tr,
                        style: TextStyle(
                            fontSize: 10,
                            color: labelColor,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                pageIndex = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                    pageIndex == 1
                        ? Image.asset(
                            Assets.iconRefer,
                            height: 32,
                          )
                        : Image.asset(
                            Assets.iconReferTwo,
                            height: 30,
                ),
                pageIndex == 1
                    ?  Text(
                        'Refer'.tr,
                        style: TextStyle(
                            fontSize: 11,
                            color: tertiary,
                            fontWeight: FontWeight.bold),
                      )
                    :  Text(
                        'Refer'.tr,
                        style: TextStyle(
                            fontSize: 10,
                            color: labelColor,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                pageIndex = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pageIndex == 2
                      ? Image.asset(
                          Assets.iconAdda,
                          height: 32,
                        )
                      : Image.asset(
                          Assets.iconAddaTwo,
                          height: 30,
                        ),
                pageIndex == 2
                    ?  Text(
                        'Adda'.tr,
                        style: TextStyle(
                            fontSize: 11,
                            color: tertiary,
                            fontWeight: FontWeight.bold),
                      )
                    :  Text(
                        'Adda'.tr,
                        style: TextStyle(
                            fontSize: 10,
                            color: labelColor,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                pageIndex = 3;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                  pageIndex == 3
                      ? Image.asset(
                          Assets.iconAccount,
                          height: 32,
                        )
                      : Image.asset(
                          Assets.iconAccountTwo,
                          height: 30,
                ),
                pageIndex == 3
                    ?  Text(
                        'Account'.tr,
                        style: TextStyle(
                            fontSize: 11,
                            color: tertiary,
                            fontWeight: FontWeight.bold),
                      )
                    :  Text(
                        'Account'.tr,
                        style: TextStyle(
                            fontSize: 10,
                            color: labelColor,
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

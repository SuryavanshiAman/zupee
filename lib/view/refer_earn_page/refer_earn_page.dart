import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/check_network/network_message.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/Game/ludo_provider.dart';

import 'how_it_work_tab_page.dart';
import 'my_referrals_tab_page.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> with TickerProviderStateMixin{
  late StreamSubscription<ConnectivityResult> _subscription;
  @override
  Widget build(BuildContext context) {
    TabController tabContrller = TabController(length: 2, vsync: this);
    final ludoProvider=Provider.of<LudoProvider>(context);
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          ludoProvider.setConnection(false);
        });

      } else {
        setState(() {
          ludoProvider.setConnection(true);
        });
      }
    });
    return Scaffold(
      backgroundColor: appBarColor,
      appBar:AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading:  Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.bottomNevBar,
                    arguments: {"index": 0});
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,color: black,size: 30,
              ),
            ),
            Text(
              "Refer & Earn".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        bottom: TabBar(
            controller: tabContrller,
            unselectedLabelColor: tertiary.withOpacity(0.8),
            labelColor: tertiary,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: tertiary,
            dividerColor: Colors.transparent,
            tabs: [
              SizedBox(
                width: width * 0.99,
                child:  Tab(
                  text: ("How it Works".tr),
                ),
              ),
              SizedBox(
                width: width * 0.99,
                child:  Tab(
                  text: ("My Referrals".tr),
                ),
              ),
            ]),
      ),
      body:ludoProvider.isConnected? TabBarView(
        controller: tabContrller,
        children: [
          const HowItWorkTabScreen(),
          const MyReferralsTabScreen()
        ],
      ):const NetworkErrorScreen(),
    );
  }
}

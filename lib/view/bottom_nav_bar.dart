import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/account/account.dart';
import 'package:zupee/view/refer_earn_page/refer_earn_page.dart';

import 'adda/adda_page.dart';
import 'home/home_page.dart';



class BottomNevBar extends StatefulWidget {

  const BottomNevBar({Key? key}) : super(key: key);

  @override
  State<BottomNevBar> createState() => _BottomNevBarState();
}

class _BottomNevBarState extends State<BottomNevBar> {
  final pages = [
     HomeScreen(),
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
        pageIndex=(arguments['index'] ?? pageIndex);
       });
      });
   }
  Future<bool> _onWillPop() async {
    if (pageIndex > 0) {
      setState(() {
        pageIndex=0;
      });
      return false;
    } else {
      return  await Utils.showExitConfirmation(context)?? false;
    }
  }
  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: _onWillPop,
    child: Scaffold(

        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
  );
int bottom = 0;
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {

                    setState(() {

                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? Image.asset(
                    Assets.iconHome,
                    height: 32,
                  )
                      :Image.asset(
                    Assets.iconHomeTwo,
                    height: 30,
                  )
              ),
              pageIndex == 0
                  ? const Text(
                'Home',
                style: TextStyle(
                    fontSize: 11,
                    color:tertiary,
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Home',
                style: TextStyle(
                    fontSize: 10,
                    color:labelColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: pageIndex == 1
                      ?  Image.asset(
                    Assets.iconRefer,
                    height: 32,


                  )
                      :Image.asset(
                    Assets.iconReferTwo,
                    height: 30,


                  )
              ),
              pageIndex == 1
                  ? const Text(
                'Refer',
                style: TextStyle(
                    fontSize: 11,
                    color:tertiary,
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Refer',
                style: TextStyle(
                    fontSize: 10,
                    color: labelColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {

                    pageIndex = 2;

                  });
                },
                icon: pageIndex == 2
                    ? Image.asset(
                  Assets.iconAdda,
                  height: 32,
                )
                    :Image.asset(
                  Assets.iconAddaTwo,
                  height: 30,


                ),
              ),
              pageIndex == 2
                  ? const Text(
                'Adda',
                style: TextStyle(
                    fontSize: 11,
                    color: tertiary,
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Adda',
                style: TextStyle(
                    fontSize: 10,
                    color:  labelColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? Image.asset(
                  Assets.iconAccount,
                  height: 32,
                )
                    :Image.asset(
                  Assets.iconAccountTwo,
                  height: 30,


                ),
              ),
              pageIndex == 3
                  ? const Text(
                'Account',
                style: TextStyle(
                    fontSize: 11,
                    color:tertiary,
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Account',
                style: TextStyle(
                    fontSize: 10,
                    color:labelColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


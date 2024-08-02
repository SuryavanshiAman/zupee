import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';

import '../../main.dart';
class FirstList {
  String title;
  FirstList(this.title);
}
class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<FirstList> list = [

    FirstList("All"),
    FirstList("Deposit"),
    FirstList("Withdrawals"),
    FirstList("Winnings"),
    FirstList("Tournament Fee"),
    FirstList("Refund"),
    FirstList("TDS"),
    FirstList("Rewards"),
    FirstList("Misc"),
    FirstList("Withdrawal Fee"),
  ];
  List<FirstList> originalList = [];
  @override
  void initState() {
    super.initState();
    originalList = List.from(list); // Save the original list for resetting
  }
  void _onItemTapped(int index) {
    setState(() {


          if (selectedIndices.contains(index)) {
            selectedIndices.remove(index);
          } else {
            if (index != 0) {
              selectedIndices.add(index);
              selectedIndices.remove(0);
            } else {
              selectedIndices.clear();
              selectedIndices.add(0);
            }
          }


      if (index == 0) {
        // Reset the list to its original state
        list = List.from(originalList);
      } else {
        // Remove the item from its current position
        FirstList tappedItem = list.removeAt(index);
        // Insert the item at the second position
        list.insert(1, tappedItem);
      }
    });
  }
  Set<int> selectedIndices = {0};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 250,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Transaction History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: height * 0.09,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onItemTapped(index),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  height: height*0.04,
                                  // margin: EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      color: selectedIndices.contains(index) ? secondary : white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                        list[index].title,
                                        style: const TextStyle(
                                            fontSize:14,
                                            color: Colors.black),
                                      ))),
                            )
                          ],
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: height * 0.14,
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: tertiary.withOpacity(0.05),
                              child: Image.asset(
                                Assets.iconWallet,
                                scale: 8,
                              ),
                            ),
                            SizedBox(width: width*0.04,),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Sign Up Bonus",
                                    style: TextStyle(
                                        color: black, fontWeight: FontWeight.w600)),
                                Text("WELCOME TO ZUPEE",
                                    style: TextStyle(
                                        // color: red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8)),
                                // Container(
                                //   alignment: Alignment.center,
                                //   height: height*0.022,
                                //   width: width * 0.16,
                                //   decoration: const BoxDecoration(
                                //     borderRadius:
                                //     BorderRadius.all(Radius.circular(5)),
                                //     color: green,
                                //   ),
                                //   child: const Text("ACTIVE",style: TextStyle(fontSize: 10,color: white),),
                                // )
                              ],
                            ),
                            const Spacer(),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("+₹10",
                                    style: TextStyle(
                                        color: black, fontWeight: FontWeight.w600)),
                                Text("16 JUL,17:53",
                                    style: TextStyle(
                                        color: labelColor, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(width: width*0.03,),
                            const Icon((Icons.arrow_forward_ios_sharp),size: 15,)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

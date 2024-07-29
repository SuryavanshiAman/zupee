import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';

class BonusDetailsScreen extends StatefulWidget {
  const BonusDetailsScreen({super.key});

  @override
  State<BonusDetailsScreen> createState() => _BonusDetailsScreenState();
}

class _BonusDetailsScreenState extends State<BonusDetailsScreen> {
  String isSelected = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Bonus Expiry",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      backgroundColor: appBarColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(

                children: [
                  // SizedBox(width: width*0.04,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = "1";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      height: height * 0.05,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          color: isSelected == "1" ? secondary : white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: const Text("All"),
                    ),
                  ),
                  SizedBox(width: width*0.04,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = "2";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      height: height * 0.05,
                      width: width * 0.34,
                      decoration: BoxDecoration(
                          color: isSelected == "2" ? secondary : white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: const Text("Expiring Soon"),
                    ),
                  ),
                  SizedBox(width: width*0.04,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = "3";
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      height: height * 0.05,
                      width: width * 0.24,
                      decoration: BoxDecoration(
                          color: isSelected == "3" ? secondary : white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: const Text("Expired"),
                    ),
                  ),

                  // Spacer(),
                ],
              ),
            ),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Signup Bonus",
                                    style: TextStyle(
                                        color: black, fontWeight: FontWeight.w600)),
                                const Text("Expires in:2 Days",
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8)),
                               Container(
                                 alignment: Alignment.center,
                                  height: height*0.022,
                                  width: width * 0.16,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: green,
                                  ),
                                 child: const Text("ACTIVE",style: TextStyle(fontSize: 10,color: white),),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("₹1",
                                    style: TextStyle(
                                        color: black, fontWeight: FontWeight.w600)),
                                const Text("Unused:₹0.023",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 8)),
                                const Text("16 JUL,17:53 PM",
                                    style: TextStyle(
                                        color: labelColor, fontWeight: FontWeight.w500)),
                              ],
                            ),

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

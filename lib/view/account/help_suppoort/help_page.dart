import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/help_view_model.dart';

import '../../../res/custom_back_button.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  HelpViewModel helpViewModel = HelpViewModel();
  @override
  void initState() {
    helpViewModel.helpApi(context);
    super.initState();
  }

  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 200,
        leading: Row(
          children: [
            const CustomBackButton(),
            Text(
              "Help".tr,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a topic to find help",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ChangeNotifierProvider<HelpViewModel>(
                  create: (BuildContext context) => helpViewModel,
                  child: Consumer<HelpViewModel>(
                    builder: (context, resultValue, _) {
                      switch (resultValue.helpList.status) {
                        case Status.LOADING:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.ERROR:
                          return Container();
                        case Status.COMPLETED:
                          final helpData = resultValue.helpList.data!.data;
                          if (helpData != null && helpData.isNotEmpty) {
                            return ListView.builder(
                              itemCount: helpData.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ExpansionTile(
                                      title: Text(
                                        helpData[index].name ?? '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      trailing: Icon(
                                        _customTileExpanded
                                            ? Icons.minimize
                                            : Icons.add,
                                      ),
                                      children: helpData[index].support != null
                                          ? helpData[index]
                                              .support!
                                              .map((supportItem) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, RoutesName.chatPage);
                                                    },
                                                    title: Text(
                                                      supportItem.description ??
                                                          '',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    trailing: const Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      size: 14,
                                                    ),
                                                  ),
                                                  // Divider()
                                                ],
                                              );
                                            }).toList()
                                          : [],
                                      onExpansionChanged: (expanded) {
                                        setState(() {
                                          _customTileExpanded = expanded;
                                        });
                                      },
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "No Help Topic Found!",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            );
                          }
                        default:
                          return Container();
                      }
                    },
                  ),
                ),

                // Column(
                //   children: [
                //     expension("Game Related", [
                //       const ListTile(
                //         title: Text("My game automatically ended midway.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "Money deducted for entry but the game\ndidn't start. I didn't get a refund",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "My token got stuck,three skips happend\nand I was thown out of the game.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "My game did not end after the full duration\nof the game.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I don't belong to Assam,Telangana,\nNagaland, Sikkim, Arunachal Pradesh and Outside India yet I am unable to play tournaments.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("I faced other game related issue",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("Wallet & Payment", [
                //       const ListTile(
                //         title: Text("Bank withdrawal is still pending.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("UPI withdrawal is still pending. ",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I added money in my Zupee wallet but\namount is not showing",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I used a coupon to deposit money into my wallet.But the coupon was not applied.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I am not abel to see my Bank/UPI details which i added earlier.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I'm facing another wallet/payment related issue.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I am not able to play games because I am from a banned state. I want to withdraw my money",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //     ]),
                //     // const HelpRow(label:"Wallet & Payment" ,),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("TDS", [
                //       const ListTile(
                //         title: Text(
                //             "I do not understanding the TDS deduction on my withdrawal amount",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("Referrals", [
                //       const ListTile(
                //         title: Text(
                //             "I referred my friends. They joined,but I didn't receive my referral bonus.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I'm facing another referral related issue.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       )
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("Ludo Mahasangram", [
                //       const ListTile(
                //         title: Text(
                //             "I got kicked out of the next round of the  tournament even thought I won.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I signed up for Ludo Mahasangram but tournament started without me ",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I won a few rounds but i didn't win any money.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       )
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("KYC", [
                //       const ListTile(
                //         title: Text(
                //             "I submitted copy of my Driving License, but  i got rejected",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I submitted copy of my PAN Card, but  i got rejected",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I submitted copy of my Voter ID Card, but  i got rejected",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "I want to apply for manual KYC verification.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "My KYC is in pending state from a long time",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("I am facing other KYC related issue"),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       )
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("Login Issue", [
                //       const ListTile(
                //         title: Text(
                //             "I'm unable to sign-up and am geetting login",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("I'm facing another login related issue",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           size: 14,
                //         ),
                //       ),
                //     ]),
                //     Divider(
                //       height: height * 0.02,
                //     ),
                //     expension("Other Issues", [
                //       const ListTile(
                //         title: Text(
                //             "I have a suggestion to make Zupee even more fun!",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp ,size: 14,),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text(
                //             "Need an Invoice for a tournament is not visible.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp, size: 14,),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("Need an Invoice for a tournament.",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp, size: 14,),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("My favourite tournament is not visible",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp, size: 14,),
                //       ),
                //       Divider(
                //         height: height * 0.02,
                //       ),
                //       const ListTile(
                //         title: Text("Other Issues",
                //             style: TextStyle(color: black, fontSize: 14)),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp, size: 14,),
                //       ),
                //     ]),
                //   ],
                // ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Text(
                "Explore More",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const HelpRow(
                  label: "Other Issues",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class HelpRow extends StatelessWidget {
  final String label;

  const HelpRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: black, fontWeight: FontWeight.w500, fontSize: 16)),
        const Icon(Icons.add)
        // Text(value, style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 18)),
      ],
    );
  }
}

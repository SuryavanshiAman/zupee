import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/view_model/transaction_history_view_model.dart';

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
  TransactionHistoryViewModel transactionHistoryViewModel =
      TransactionHistoryViewModel();
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    transactionHistoryViewModel.transactionHistoryApi(context, selectedIndex);
    originalList = List.from(list); // Save the original list for resetting
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     if (selectedIndices.contains(index)) {
  //       selectedIndices.remove(index);
  //     } else {
  //       if (index != 0) {
  //         selectedIndices.add(index);
  //         selectedIndices.remove(0);
  //       } else {
  //         selectedIndices.clear();
  //         selectedIndices.add(0);
  //       }
  //     }
  //
  //     if (index == 0) {
  //       // Reset the list to its original state
  //       list = List.from(originalList);
  //     } else {
  //       // Remove the item from its current position
  //       FirstList tappedItem = list.removeAt(index);
  //       // Insert the item at the second position
  //       list.insert(1, tappedItem);
  //     }
  //   });
  // }
  //

  @override
  Widget build(BuildContext context) {
    final transaction = Provider.of<TransactionHistoryViewModel>(context);
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
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        transaction.transactionHistoryApi(
                            context, selectedIndex);
                        // _onItemTapped(index);
                        // print("selectedIndices$selectedIndices");
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                height: height * 0.04,
                                // margin: EdgeInsets.all(3),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? secondary
                                        : white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  list[index].title,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ))),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Consumer<TransactionHistoryViewModel>(
                builder: (context, resultValue, _) {
                  switch (resultValue.transactionHistoryList.status) {
                    // case Status.LOADING:
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    case Status.ERROR:
                      return Container();
                    case Status.COMPLETED:
                      final transaction =
                          resultValue.transactionHistoryList.data!.data;
                      if (transaction != null && transaction.isNotEmpty) {
                        return ListView.builder(
                            itemCount: transaction.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height: height * 0.14,
                                  decoration: const BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Assets.imagesCashback,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: width * 0.04,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              transaction[index]
                                                  .type
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              transaction[index]
                                                  .description
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              "+₹${transaction[index].amount.toString()}",
                                              style: const TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                              DateFormat("dd/MM/,HH:mm")
                                                  .format(DateTime.parse(
                                                transaction[index]
                                                    .datetime
                                                    .toString(),
                                              )),
                                              // "16 JUL,17:53",
                                              style: const TextStyle(
                                                  color: labelColor,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      const Icon(
                                        (Icons.arrow_forward_ios_sharp),
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: Text(
                            "No Transaction History Found!",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        );
                      }
                    default:
                      return const Center(
                        child: Text(
                          "No Transaction History Found!",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      );
                  }
                },
              ),
              // child: ChangeNotifierProvider<TransactionHistoryViewModel>(
              //   create: (BuildContext context) => transactionHistoryViewModel,
              //   child:Consumer<TransactionHistoryViewModel>(
              //     builder: (context, resultValue, _) {
              //       switch (resultValue.transactionHistoryList.status) {
              //         case Status.LOADING:
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         case Status.ERROR:
              //           return Container();
              //         case Status.COMPLETED:
              //           final transaction =
              //               resultValue.transactionHistoryList.data!.data;
              //           if (transaction != null && transaction.isNotEmpty) {
              //             return ListView.builder(
              //                 itemCount: transaction.length,
              //                 scrollDirection: Axis.vertical,
              //                 shrinkWrap: true,
              //                 itemBuilder: (BuildContext context, int index) {
              //                   return Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Container(
              //                       padding: const EdgeInsets.all(8),
              //                       height: height * 0.14,
              //                       decoration: const BoxDecoration(
              //                           color: white,
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(10))),
              //                       child: Row(
              //                         // crossAxisAlignment: CrossAxisAlignment.start,
              //                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           Image.asset(
              //                             Assets.imagesCashback,
              //                             scale: 3,
              //                           ),
              //                           SizedBox(
              //                             width: width * 0.04,
              //                           ),
              //                            Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceEvenly,
              //                             children: [
              //                               Text(transaction[index].type.toString(),
              //                                   style: const TextStyle(
              //                                       color: black,
              //                                       fontWeight: FontWeight.w600)),
              //                               Text(transaction[index].description.toString().toUpperCase(),
              //                                   style: const TextStyle(
              //                                       // color: red,
              //                                       fontWeight: FontWeight.w600,
              //                                       fontSize:8 )),
              //                               // Container(
              //                               //   alignment: Alignment.center,
              //                               //   height: height*0.022,
              //                               //   width: width * 0.16,
              //                               //   decoration: const BoxDecoration(
              //                               //     borderRadius:
              //                               //     BorderRadius.all(Radius.circular(5)),
              //                               //     color: green,
              //                               //   ),
              //                               //   child: const Text("ACTIVE",style: TextStyle(fontSize: 10,color: white),),
              //                               // )
              //                             ],
              //                           ),
              //                           const Spacer(),
              //                            Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.end,
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceEvenly,
              //                             children: [
              //                               Text("+₹${transaction[index].amount.toString()}",
              //                                   style: const TextStyle(
              //                                       color: black,
              //                                       fontWeight: FontWeight.w600)),
              //                                Text(
              //                                   DateFormat("dd/MM/,HH:mm")
              //                                       .format(DateTime.parse(
              //                                     transaction[index].datetime.toString(),
              //                                   )),
              //                                   // "16 JUL,17:53",
              //                                   style: TextStyle(
              //                                       color: labelColor,
              //                                       fontWeight: FontWeight.w500)),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             width: width * 0.03,
              //                           ),
              //                           const Icon(
              //                             (Icons.arrow_forward_ios_sharp),
              //                             size: 15,
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   );
              //                 });
              //           } else {
              //             return const Center(
              //               child: Text(
              //                 "No Transaction History Found!",
              //                 style: TextStyle(color: Colors.black, fontSize: 16),
              //               ),
              //             );
              //           }
              //         default:
              //           return Center(
              //             child: Text(
              //               "No Transaction History Found!",
              //               style: TextStyle(color: Colors.black, fontSize: 16),
              //             ),
              //           );
              //       }
              //     },
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

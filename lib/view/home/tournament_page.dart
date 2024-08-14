import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_container.dart';
import 'package:zupee/res/time_page.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/bottomsheet/tournament_bottomsheet.dart';
import 'package:zupee/view_model/firebase_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';

class FirstList {
  String title;
  FirstList(this.title);
}

class SecondList {
  String title;
  SecondList(this.title);
}

class NewOne {
  String? title;
  String titleOne;
  NewOne(this.title, this.titleOne);
}

class LudoSupreme extends StatefulWidget {
  const LudoSupreme({super.key});

  @override
  LudoSupremeState createState() => LudoSupremeState();
}

class LudoSupremeState extends State<LudoSupreme>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  // bool _showImage = true;

  bool _showTitle = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  Duration myDuration = const Duration(days: 5);

  void _handleScroll() {
    setState(() {
      if (_scrollController.position.pixels > 100) {
        // _showImage = false;
        _showTitle = false;
      } else {
        // _showImage = true;
        _showTitle = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool nextPage = true;
  int setTime = 0;
  // void _updateTimerValue(int value, context) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (value == 10 && nextPage==false ) {
  //       Navigator.pushNamed(context, RoutesName.timerScreen);
  //     } else if (value == 9 ) {
  //      setState(() {
  //        nextPage==true;
  //      });
  //     }
  //    else {
  //       setState(() {
  //         setTime = (value - 1) % 60;
  //       });
  //     }
  //   });
  // }
  int _seconds = 10;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _timer?.cancel();
          Navigator.pushNamed(context, RoutesName.ludoHomeScreen);
        } else {
          _seconds--;
        }
      });
    });
  }

  bool time = false;
  bool _isExpanded = false;
  Set<int> selectedIndices = {0};
  @override
  Widget build(BuildContext context) {
    List<FirstList> list = [
      FirstList("All"),
      FirstList("QUICK"),
      FirstList("4 Players - 1 Winner"),
      FirstList("2 Players - 1 winner"),
      FirstList("4 Players - 2 Winners"),
    ];

    List<NewOne> addAmount = [
      NewOne("₹150", "₹50"),
      NewOne("₹140", "₹40"),
      NewOne("₹100", "₹40"),
      NewOne("₹50", "₹20"),
      NewOne("₹40", "₹10"),
    ];

    List<SecondList> listNew = [
      SecondList("4 Players - 2 Winners"),
      SecondList("2 Players - 1 Winners"),
      SecondList("4 Players - 2 Winners"),
      SecondList("2 Players - 1 Winners"),
      SecondList("2 Players - 1 Winners"),
    ];
    return Scaffold(
      backgroundColor: appBarColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size(300.0, 100.0),
              child: Container(
                  decoration: const BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: height * 0.095,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
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
                            });
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    height: height * 0.045,
                                    padding: const EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                        color: selectedIndices.contains(index)
                                            ? secondary
                                            : white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      list[index].title.tr,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: black),
                                    ))),
                              )
                            ],
                          ),
                        );
                      })),
            ),

            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: !_showTitle ? black : white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: !_showTitle
                ? const Text(
                    " Ludo Supreme",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )
                : const Text(""),
            // centerTitle: true,
            backgroundColor: _showTitle ? blue : Colors.white,
            pinned: true,
            snap: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
                // collapseMode: CollapseMode.pin,
                centerTitle: true,
                background: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: height * 0.12,
                          width: width * 0.3,
                          child: Image.asset(
                            Assets.imagesLudoSupreem,
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                        width: width * 0.25,
                      ),
                      Image(
                        image: const AssetImage(
                          Assets.imagesVideo,
                        ),
                        height: height * 0.07,
                      )
                    ],
                  ),
                )),
            expandedHeight: 250,
            actions: [
              _showTitle
                  ? Icon(
                      Icons.notifications_none,
                      color: _showTitle ? Colors.white : tertiary,
                      size: 35,
                    )
                  : Container(),
              Container(
                alignment: Alignment.center,
                height: height * 0.05,
                width: width * 0.25,
                decoration: BoxDecoration(
                    color: _showTitle ? Colors.white : tertiary,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Text(
                  "₹6",
                  style: TextStyle(
                      color: _showTitle ? tertiary : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: width * 0.04,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.depositScreen);
                },
                child: Image.asset(
                  _showTitle
                      ? Assets.imagesRupeesWhite
                      : Assets.imagesRupeesBlue,
                  scale: 2.5,
                ),
              ),
              SizedBox(
                width: width * 0.04,
              ),
            ],
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Recommended Tournaments".tr,
                style: TextStyle(
                    fontSize: width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: height * 0.03),
              time
                  ? Container(
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hourglass_empty,
                              color: Colors.green, size: 50),
                          const SizedBox(height: 10),
                          Text(
                            'Game starting in...'.tr,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            decoration: const BoxDecoration(
                              color: green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                            ),
                            child: CountdownTimer(
                              onTimerTick: (int value) {
                                // _updateTimerValue(value, context);
                              },
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: green,
                          ),
                          Text(
                            '4 PLAYERS • 2 WINNERS • ₹16 Prize'.tr,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addAmount.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            confirmPaymentBottomSheet(context);
                          },
                          child: Container(
                            height: height * 0.18,
                            decoration: const BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.04,
                                  width: width,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.people_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      const Text("2130+",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      SizedBox(
                                        width: width * 0.16,
                                      ),
                                      Text(listNew[index].title.tr,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.04, right: width * 0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("PRIZE POOL".tr,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: labelColor,
                                              fontWeight: FontWeight.w500
                                              // fontWeight: FontWeight.bold
                                              )),
                                      Text("ENTRY".tr,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: labelColor,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                              addAmount[index].title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: black,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: height * 0.02,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                              color: lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.watch_later_outlined,
                                                color: red,
                                                size: 12,
                                              ),
                                              CountdownTimer(
                                                onTimerTick: (int value) {},
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                color: red,
                                              ),
                                              // Text('${minutes}m',
                                              //     style: const TextStyle(
                                              //       fontSize: 12,
                                              //       color: red,
                                              //     )),
                                              // Text('${seconds}s',
                                              //     style: const TextStyle(
                                              //       fontSize: 12,
                                              //       color: red,
                                              //     )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: secondary,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              height: height * 0.05,
                                              width: width * 0.3,
                                              decoration: const BoxDecoration(
                                                color: Colors
                                                    .blue, // Replace with your secondary color
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                            ),
                                          ),
                                          CustomContainer(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RoutesName.ludoSupreme);
                                            },
                                            height: height * 0.05,
                                            widths: width * 0.3,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                            ),
                                            child: Text(
                                              addAmount[index].titleOne,
                                              style: const TextStyle(
                                                color:
                                                    tertiary, // Replace with your tertiary color
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: height * 0.03,
              ),
              Text("Other Tournaments".tr,
                  style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: addAmount.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          child: Container(
                            // padding: const EdgeInsets.all(8.0),
                            height: height * 0.18,
                            // width: width*0.5,
                            decoration: const BoxDecoration(
                                // color: Colors.red,
                                color: white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.04,
                                  width: width,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.people_outline,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      Text("2130+",
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.black)),
                                      SizedBox(
                                        width: width * 0.16,
                                      ),
                                      Text(listNew[index].title,
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.04, right: width * 0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("PRIZE POOL".tr,
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: labelColor,
                                              fontWeight: FontWeight.w400
                                              // fontWeight: FontWeight.bold
                                              )),
                                      Text("ENTRY".tr,
                                          style: TextStyle(
                                              fontSize: width * 0.03,
                                              color: labelColor,
                                              fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                            color: lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                              addAmount[index].title.toString(),
                                              style: TextStyle(
                                                  fontSize: width * 0.05,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: height * 0.02,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                              color: lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.watch_later_outlined,
                                                color: red,
                                                size: 12,
                                              ),
                                              CountdownTimer(
                                                onTimerTick: (int value) {},
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                                color: red,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(addAmount[index].titleOne,
                                              style: TextStyle(
                                                  fontSize: width * 0.05,
                                                  color: tertiary,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ]),
          ))
        ],
      ),
    );
  }


  void sendJsonDataToFirebase(Map<String, dynamic> jsonData) async {
    // Reference to the Firestore collection "ludo"
    CollectionReference ludoCollection = FirebaseFirestore.instance.collection('ludo');

    // Add the JSON data to the collection
    await ludoCollection.add(jsonData).then((docRef) {
      print("Document added with ID: ${docRef.id}");
    }).catchError((error) {
      print("Error adding document: $error");
    });
  }
  void confirmPaymentBottomSheet(BuildContext context) async {
    final profile =
        Provider.of<ProfileViewModel>(context, listen: false).profileResponse;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          // height: height*0.47,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel_outlined,
                      size: 30, color: black)),
              const Center(
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: appBarColor,
                    child: Center(
                        child:
                            Image(image: AssetImage(Assets.imagesRupeesBlue)))),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Confirm Payment'.tr,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 18.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Entry Fee'.tr,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        const Text('₹1',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Icon(_isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more))
                      ],
                    ),
                    if (_isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            const Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('From Bonus'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                      Text(
                                        'From Cashback'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: labelColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 8),
                                      Text('From Winning & Deposits'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('₹0',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                      SizedBox(height: 8),
                                      Text(' ₹1',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                      Text('₹0',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Entry Fee Breakdown'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        'To Prize Pool'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: labelColor),
                                      ),
                                      const SizedBox(height: 8),
                                      Text('To Platform Fee'.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('', style: TextStyle(fontSize: 16)),
                                      SizedBox(height: 8),
                                      Text(' ₹0.8',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                      Text('₹0.2',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: labelColor)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Center(
                child: CustomContainer(
                  onTap: () async {
                    setState(() {
                      _startTimer();
                      nextPage = false;
                      time = true;
                    });
                    // Navigator.pop(context);
                    Map<String, dynamic> jsonData = {
                      'player1': '{"name":"${profile!.data!.username}","id":"${profile.data!.id}","image":"${profile.data!.profilePicture}"}',
                    };
                    sendJsonDataToFirebase(jsonData);
                    showModalBottomSheet(
                      elevation: 5,
                      backgroundColor: primary,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      context: context,
                      builder: (context) {
                        return TournamentBottomsheet();
                      },
                    );
                  },
                  alignment: Alignment.center,
                  height: height * 0.07,
                  widths: width * 0.8,
                  color: secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child: Text(
                    "Join Now".tr,
                    style: const TextStyle(
                        fontSize: 16,
                        color: tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

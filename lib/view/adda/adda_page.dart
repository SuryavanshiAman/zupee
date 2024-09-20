import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/check_network/network_message.dart';
import 'package:zupee/res/custom_rich_text.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/adda_player_list_view_model.dart';

import '../../res/custom_back_button.dart';
import '../../utils/routes_name.dart';

class AddaScreen extends StatefulWidget {
  const AddaScreen({super.key});

  @override
  State<AddaScreen> createState() => _AddaScreenState();
}

class _AddaScreenState extends State<AddaScreen> {
  // PlayerRankViewModel playerRankViewModel = PlayerRankViewModel();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerRankViewModel>(context, listen: false)
          .tournamentApi(context);
    });
  }
  late StreamSubscription<ConnectivityResult> _subscription;
  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 220,
        leading: Row(
          children: [
            // CustomBackButton(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.bottomNevBar,
                    arguments: {"index": 0});
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
                size: 30,
              ),
            ),
            Text(
              "Adda".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body:ludoProvider.isConnected? Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          shrinkWrap: false,
          children: [
            const SizedBox(height: 16),
            Text(
              "Top Players(Past 7 days)".tr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            CustomRichText(textSpans: [
              CustomTextSpan(
                  text: "LAST UPDATE:".tr,
                  fontSize: 10,
                  textColor: labelColor,
                  fontWeight: FontWeight.w500),
              CustomTextSpan(
                  text: "TODAY,12:00 AM".tr,
                  fontSize: 10,
                  textColor: labelColor,
                  fontWeight: FontWeight.w500),
            ]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Text("😎"),
                            ),
                            // Icon(Icons.ac_unit),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.leaderboardScreen);
                              },
                              child: Text(
                                'VIEW ALL'.tr,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: tertiary),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 20,
                            ),
                          ],
                        ),
                        const Text(
                          'Ludo Supreme League Maukebaaz',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Players whoo have won big in Ludo Supreme League',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: labelColor),
                        ),
                        SizedBox(height: height * 0.02),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            SizedBox(
                              // width: width,
                              height: height * 0.14,
                              child: addaList(),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        const Divider()
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Top players for you to follow".tr,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            SizedBox(
              height: height * 0.24,
              child: Consumer<PlayerRankViewModel>(
                builder: (context, playerRankData, _) {
                  switch (playerRankData.playerRankList.status) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.ERROR:
                      return Container();
                    case Status.COMPLETED:
                      final playerRank =
                          playerRankData.playerRankList.data!.data;
                      if (playerRank != null && playerRank.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playerRank.length,
                          itemBuilder: (context, index) {
                            final playerRankData = playerRank[index];
                            return buildTopScorerCard(
                              playerRankData.username.toString(),
                              playerRankData.profilePicture.toString(),
                              index,

                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "No Player History Found!",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        );
                      }
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ):const NetworkErrorScreen(),
    );
  }




  Widget addaList() {
    return Consumer<PlayerRankViewModel>(
      builder: (context, playerRankData, _) {
        switch (playerRankData.playerRankList.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.ERROR:
            return Container();
          case Status.COMPLETED:
            final playerRank = playerRankData.playerRankList.data!.data;
            if (playerRank != null && playerRank.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: playerRank.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.userProfileScreen,arguments: playerRank[index]);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  playerRank[index].profilePicture.toString()),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'RANK #${playerRank[index].userRank}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(playerRank[index].username.toString(),
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text(
                  "No Player History Found!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              );
            }
          default:
            return Container();
        }
      },
    );
  }
bool selectedIndex =false;
  Set<int> followedIndices = {};
  Widget buildTopScorerCard(String name, String imageUrl,index) {
    bool isFollowed = followedIndices.contains(index);
    return Container(
      width: width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: labelColor),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Spacer(),
            const SizedBox(height: 8),
            InkWell(
              onTap: (){
                setState(() {
                  if (followedIndices.contains(index)) {
                    followedIndices.remove(index); // Unfollow
                  } else {
                    followedIndices.add(index); // Follow
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.045,
                width: width * 0.7,
                decoration: BoxDecoration(
                    color:isFollowed ? lightBlue:white,
                    border: Border.all(color:isFollowed ?Colors.transparent: tertiary),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child:  Text(
                  isFollowed ? "Following":'Follow',
                  style: const TextStyle(
                    fontSize: 16,
                    color: tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

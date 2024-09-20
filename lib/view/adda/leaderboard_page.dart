import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../res/app_colors.dart';
import '../../res/custom_back_button.dart';
import '../../view_model/adda_player_list_view_model.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  PlayerRankViewModel playerRankViewModel = PlayerRankViewModel();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerRankViewModel>(context, listen: false)
          .tournamentApi(context);
    });
  }

  void _showPlayerDetails(int index) {
    showDialog(
      barrierColor: black.withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: PlayerDetailsCarousel(
            initialIndex: index,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerRankViewModel = Provider.of<PlayerRankViewModel>(context);

    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        // leadingWidth: 220,
        leading: const CustomBackButton(),
        title: const Text(
          "Ludo Supreme League Maukebaaz",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.03),
          const Text(
            "Ludo Supreme League",
            style: TextStyle(
                fontSize: 18, color: tertiary, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: height * 0.01),
          Container(
            height: 1.5,
            width: width * 0.55,
            color: tertiary,
          ),
          Container(
            height: height * 0.29,
            width: width,
            color: lightBlue,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  height: height * 0.03,
                  width: width * 0.8,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.imagesMaukebaaz),
                          fit: BoxFit.fill)),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "😎",
                        style: TextStyle(
                            color: tertiary, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Ludo Supreme League Maukebaaz",
                        style: TextStyle(
                            color: tertiary, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.1,
                              width: width * 0.21,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white,
                                  border:
                                      Border.all(color: tertiary, width: 2)),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 33,
                                  backgroundImage: NetworkImage(
                                      playerRankViewModel.playerRankList.data
                                              ?.data?[1].profilePicture ??
                                          "0"),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(26.0, 60, 0, 0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: white,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: tertiary,
                                  child: Text("#2",
                                      style: TextStyle(
                                          color: secondary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                            playerRankViewModel
                                    .playerRankList.data?.data?[1].username ??
                                "0",
                            // "Aman",
                            style: const TextStyle(
                                color: tertiary, fontWeight: FontWeight.bold)),
                        Text(
                            "₹${playerRankViewModel.playerRankList.data?.data?[1].totalWinAmount ?? "0"}",
                            style: const TextStyle(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.14,
                              width: width * 0.28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white,
                                  border:
                                      Border.all(color: tertiary, width: 2)),
                              child: Center(
                                  child: CircleAvatar(
                                radius: 47,
                                backgroundImage: NetworkImage(
                                    playerRankViewModel.playerRankList.data
                                            ?.data?[0].profilePicture ??
                                        "0"),
                              )),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(42.0, 90, 0, 0),
                              child: CircleAvatar(
                                radius: 17,
                                backgroundColor: white,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: tertiary,
                                  child: Text("#1",
                                      style: TextStyle(
                                          color: secondary,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                            playerRankViewModel
                                    .playerRankList.data?.data?[0].username ??
                                "0",
                            style: const TextStyle(
                              color: tertiary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        Text(
                            "₹${playerRankViewModel.playerRankList.data?.data?[0].totalWinAmount ?? "0"}",
                            style: const TextStyle(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    if (playerRankViewModel.playerRankList.data?.data != null &&
                        playerRankViewModel.playerRankList.data!.data!.length >
                            2)
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: height * 0.1,
                                width: width * 0.21,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: white,
                                    border:
                                        Border.all(color: tertiary, width: 2)),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 33,
                                    backgroundImage: NetworkImage(
                                        playerRankViewModel.playerRankList.data
                                                ?.data?[2].profilePicture ??
                                            "0"),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(26.0, 60, 0, 0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: white,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: tertiary,
                                    child: Text("#3",
                                        style: TextStyle(
                                            color: secondary,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                              playerRankViewModel
                                      .playerRankList.data?.data?[2].username ??
                                  "0",
                              style: const TextStyle(
                                  color: tertiary,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              "₹${playerRankViewModel.playerRankList.data?.data?[2].totalWinAmount ?? "0"}",
                              style: const TextStyle(
                                  color: black, fontWeight: FontWeight.bold)),
                        ],
                      )
                    else
                      Container(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.022,
            width: width,
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: width * 0.08),
                const Text("RANK",
                    style: TextStyle(color: labelColor, fontSize: 10)),
                SizedBox(width: width * 0.15),
                const Text("NAME",
                    style: TextStyle(color: labelColor, fontSize: 10)),
                SizedBox(width: width * 0.15),
                const Text("AMUNT WON",
                    style: TextStyle(color: labelColor, fontSize: 10)),
                const Spacer()
              ],
            ),
          ),
          Expanded(
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
                    final playerRank = playerRankData.playerRankList.data!.data;
                    if (playerRank != null && playerRank.isNotEmpty) {
                      return ListView.builder(
                        itemCount: playerRank.length-3,
                        itemBuilder: (context, index) {
                          final actualIndex = index + 3;
                          return InkWell(
                            onTap: () {
                              _showPlayerDetails(actualIndex);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // padding: EdgeInsets.all(8),
                                height: height * 0.06,
                                width: width,
                                decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      playerRank[actualIndex].userRank.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: secondary,
                                      backgroundImage: NetworkImage(playerRank[actualIndex].profilePicture.toString()),
                                    ),
                                    SizedBox(
                                      width: width * 0.24,
                                      // color: Colors.red,
                                      child: Text(
                                        playerRank[actualIndex].username.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: labelColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.24,
                                      // color: Colors.red,
                                      child: Text(
                                        "₹${playerRank[actualIndex].totalWinAmount.toString()}"
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Text(
                                      "FOLLOW",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: tertiary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
          )
        ],
      ),
    );
  }
}

class PlayerDetailsCarousel extends StatelessWidget {
  final int initialIndex;

  const PlayerDetailsCarousel({
    super.key,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final playerRankViewModel = Provider.of<PlayerRankViewModel>(context);
    final playerRank = playerRankViewModel.playerRankList.data!.data;
    return CarouselSlider.builder(
      itemCount: playerRank!.length,
      options: CarouselOptions(
        initialPage: initialIndex,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.85,
        enlargeFactor: 0.3,
        height: height * 0.5,
      ),
      itemBuilder: (context, index, realIdx) {
        final player = playerRank[index];
        return Card(
          color: white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(player.profilePicture ?? ''),
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    player.username!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    color: lightBlue,
                    child: Text(
                      'Rank: #${player.userRank}',
                      style: const TextStyle(fontSize: 16, color: black),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Center(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${player.userid} Followers',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '${player.userid} Games Played',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Container(
                            height: height * 0.03,
                            width: width * 0.002,
                            color: labelColor,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${player.userid} Following',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '${player.userid} Games Won',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 18),
                    height: height * 0.05,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: const Text(
                      "Follow",
                      style: TextStyle(
                          color: tertiary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.userProfileScreen,arguments: playerRank[index] );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "VIEW FULL PROFILE",
                          style: TextStyle(
                              color: tertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: tertiary,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

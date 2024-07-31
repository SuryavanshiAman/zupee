import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../res/app_colors.dart';
import '../../res/custom_back_button.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final List<Map<String, String>> otherPlayers = [
    {
      'rank':'4',
      'name': 'is it fair Game',
      'amount': '₹14.4L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'5',
      'name': 'rakesh Kumar kumawat',
      'amount': '₹12.2L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'6',
      'name': 'Tirtha Mondal You...',
      'amount': '₹11.5L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'7',
      'name': 'jitna hain',
      'amount': '₹8.12L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'8',
      'name': 'Akshaya Valvaiker',
      'amount': '₹6.82L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'9',
      'name': 'Jai shri ram',
      'amount': '₹6.49L',
      'image': 'URL_TO_IMAGE',
    },
    {
      'rank':'10',
      'name': 'BholeNath baba',
      'amount': '₹5.49L',
      'image': 'URL_TO_IMAGE',
    },
  ];

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
            players: otherPlayers,
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
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
                  height: height*0.03,
                  width: width*0.8,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.imagesMaukebaaz),fit: BoxFit.fill)
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("😎",style: TextStyle(color: tertiary,fontWeight: FontWeight.w600),),
                      Text("Ludo Supreme League Maukebaaz",style: TextStyle(color: tertiary,fontWeight: FontWeight.w600),)
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
                              child: const Center(
                                child: CircleAvatar(
                                  radius: 33,
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(26.0, 60, 0, 0),
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
                        const Text("Aman",
                            style: TextStyle(
                                color: tertiary, fontWeight: FontWeight.bold)),
                        const Text("₹2,54,688",
                            style: TextStyle(
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
                              child: const Center(
                                  child: CircleAvatar(
                                radius: 47,
                              )),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(42.0, 90, 0, 0),
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
                        const Text("Aman",
                            style: TextStyle(
                              color: tertiary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        const Text("₹2,54,688",
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
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
                              child: const Center(
                                child: CircleAvatar(
                                  radius: 33,
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(26.0, 60, 0, 0),
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
                        const Text("Aman",
                            style: TextStyle(
                                color: tertiary, fontWeight: FontWeight.bold)),
                        const Text("₹2,54,688",
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
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
                const Text("RANK", style: TextStyle(color: labelColor, fontSize: 10)),
                SizedBox(width: width * 0.15),
                const Text("NAME", style: TextStyle(color: labelColor, fontSize: 10)),
                SizedBox(width: width * 0.15),
                const Text("AMUNT WON",
                    style: TextStyle(color: labelColor, fontSize: 10)),
                const Spacer()
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: otherPlayers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    _showPlayerDetails(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      height: height * 0.06,
                      width: width,
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: width*0.02),
                          Text(
                      otherPlayers[index]["rank"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: width*0.02),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: secondary,
                            child: Image.asset(Assets.iconAccount,scale: 8,),
                          ),
                          SizedBox(
                            width: width * 0.24,
                            // color: Colors.red,
                            child: Text(
                              otherPlayers[index]["name"].toString(),
                              style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: labelColor),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.24,
                            // color: Colors.red,
                            child: Text(
                              otherPlayers[index]["amount"].toString(),
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Text(
                            "FOLLOW",
                            style: TextStyle(fontWeight: FontWeight.w600,color: tertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
  final List<Map<String, String>> players;

  const PlayerDetailsCarousel({
    Key? key,
    required this.initialIndex,
    required this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: players.length,
      options: CarouselOptions(
        initialPage: initialIndex,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.85,
        enlargeFactor: 0.3,
        height: height*0.5,
      ),
      itemBuilder: (context, index, realIdx) {
        final player = players[index];
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
                    backgroundImage: NetworkImage(player['image'] ?? ''),
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(height: height*0.03),
                  Text(
                    player['name']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height*0.03),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    color: lightBlue,
                    child: Text(
                      'Rank: #${player['rank']}',
                      style: const TextStyle(fontSize: 16, color: black),
                    ),
                  ),
                  SizedBox(height: height*0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Center(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${player['followers']} Followers',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '${player['gamesPlayed']} Games Played',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                                '${player['gamesWon']} Following',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                '${player['gamesWon']} Games Won',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                      // border: Border.all(color: lightGray),
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
                  SizedBox(height: height*0.03),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.userProfileScreen);
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
                        Icon(Icons.arrow_forward_ios_sharp,color: tertiary,size: 15,)
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.03),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
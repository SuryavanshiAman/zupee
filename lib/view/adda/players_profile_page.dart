import 'package:flutter/material.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/model/player_rank_model.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/utils/routes_name.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Data? player = ModalRoute.of(context)!.settings.arguments as Data?;
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
          backgroundColor: appBarColor,
          leading: const CustomBackButton(),
          title:  Text(
            "${ player?.username.toString()??""}'s Profile",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                     CircleAvatar(
                      radius: 52,
                      backgroundColor: tertiary,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage( player?.profilePicture.toString()??"",),
                        // child: Image(image:  NetworkImage( player?.profilePicture.toString()??"",),height: height*0.1,),// Replace with actual image path
                      ),
                    ),
                    const SizedBox(height: 16),
                     Text(
                       player?.username.toString()??"",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Followers',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '81667',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                        const Column(
                          children: [
                            Text(
                              'Following',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 18),
                      height: height * 0.06,
                      width: width * 0.9,
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
                  ],
                ),
              ),
            ),
            // Trending Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      '${player?.username.toString()??""} is Trending!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'in Zupee Leaderboard',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Stack(children: [
                        Image.asset(
                          Assets.imagesWinner,
                          scale: 1.8,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.24, height * 0.23, 0, 0),
                          child:  CircleAvatar(
                            radius: 30,
                            backgroundColor: white,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: tertiary,
                              child: Text("#${player?.userRank.toString()??""}",
                                  style: const TextStyle(
                                      color: secondary,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ]),
                    ), // Replace with actual image path
                    const SizedBox(height: 16),
                     Center(
                      child: Text(
                        player?.username.toString()??"",
                        style: const TextStyle(
                          fontSize: 18,
                          color: tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                     Center(
                      child: Text(
                        'RANK #${player?.userRank.toString()??""}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Game History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.gameHistoryScreen);
                        // Handle My Game History tap
                      },
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.gameHistoryScreen);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.videogame_asset,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Total Games\n Played till today',
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '4',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: lightBlue,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Total Games\n Won till today',
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            )
          ],
        ),
      ),
    );
  }
}

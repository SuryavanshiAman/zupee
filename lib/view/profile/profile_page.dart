import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/adda_player_list_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, String>> topScorers = [
    {
      'name': 'Yogesh lodhi',
      'subtitle': 'Mahasangram Winners\nLudo Supreme',
      'imageUrl': 'https://placekitten.com/200/200',
    },
    {
      'name': 'ANSH PRATAP Singh',
      'subtitle': 'Purane Khiladi',
      'imageUrl': 'https://placekitten.com/200/200',
    },
    // Add more scorers as needed
  ];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlayerRankViewModel>(context, listen: false)
          .tournamentApi(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context).profileResponse?.data;
    final profileData = Provider.of<ProfileViewModel>(context).profileResponse?.gameStatus;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading:  Row(
          children: [
            const CustomBackButton(),
            Text(
              "My Profile".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      profileViewModel!.profilePicture != null
                          ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            profileViewModel.profilePicture
                                .toString()),
                      )
                          :  const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            Assets.iconAccount),
                      ),

                      const SizedBox(height: 16),
                       Text(
                        profileViewModel?.username.toString()??profileViewModel?.mobileNumber.toString()??"",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Followers'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                           Column(
                            children: [
                              Text(
                                'Following'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.editProfileScreen);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height*0.06,
                          width: width*0.7,
                          decoration: const BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.all(Radius.circular(25))
                          ),
                          child:   Text(
                            'Edit Profile'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              color: tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
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
                      title:  Text(
                        'My Game History'.tr,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp,size: 20,),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.gameHistoryScreen);
                        // Handle My Game History tap
                      },
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.gameHistoryScreen);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:lightBlue,
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
                              child:  Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.videogame_asset,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total Games\n Played till today'.tr,
                                      // textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                     Text(
                                       profileData?.totalGames.toString()??"0",
                                      style: const TextStyle(
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
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.emoji_events,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total Games\n Won till today'.tr,
                                      // textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                     Text(
                                      profileData?.winGame.toString()??"0",
                                      style: const TextStyle(
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
              SizedBox(height:  height*0.03,),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title:  Text(
                        'Top scorer this week'.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp,size: 20,),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.bottomNevBar ,arguments: {"index": 2});
                      },
                    ),
                     SizedBox(height: height*0.01),
                    // SizedBox(
                    //   height: height*0.25,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: topScorers.length,
                    //     itemBuilder: (context, index) {
                    //       final scorer = topScorers[index];
                    //       return buildTopScorerCard(
                    //         scorer['name']!,
                    //         scorer['subtitle']!,
                    //         scorer['imageUrl']!,
                    //       );
                    //     },
                    //   ),
                    // ),
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
              ),


            ],
          ),
        ),
      )
    );
  }
  // Widget buildTopScorerCard(String name, String subtitle, String imageUrl) {
  //   return Container(
  //     width: width*0.4,
  //     margin: const EdgeInsets.symmetric(horizontal: 4),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: labelColor),
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.2),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           SizedBox(height: height*0.01),
  //           CircleAvatar(
  //             radius: 30,
  //             backgroundImage: NetworkImage(imageUrl),
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             name,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             subtitle,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //               fontSize: 12,
  //               color: Colors.black54,
  //             ),
  //           ),
  //            Spacer(),
  //           Container(
  //             alignment: Alignment.center,
  //             height: height*0.045,
  //             width: width*0.7,
  //             decoration: BoxDecoration(
  //                 // color: secondary,
  //                 border: Border.all(color: tertiary),
  //                 borderRadius: const BorderRadius.all(Radius.circular(25))
  //             ),
  //             child:   Text(
  //               'Follow'.tr,
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 color: tertiary,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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

import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/utils/routes_name.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "My Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.yellow,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '+9174xxxx6942',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                            child: const VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          const Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
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
                          child:  const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                              color: tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Handle edit profile button press
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: Colors.purple, backgroundColor: Colors.yellow,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 24, vertical: 12),
                      //     child: Text(
                      //       'Edit Profile',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                      title: const Text(
                        'My Game History',
                        style: TextStyle(
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
                                    offset: const Offset(0, 3), // changes position of shadow
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
              // Container(
              //   height: height*0.3,
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
              SizedBox(height:  height*0.03,),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Top scorer this week',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp,size: 20,),
                      onTap: () {
                        // Handle top scorer tap
                      },
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: height*0.25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topScorers.length,
                        itemBuilder: (context, index) {
                          final scorer = topScorers[index];
                          return buildTopScorerCard(
                            scorer['name']!,
                            scorer['subtitle']!,
                            scorer['imageUrl']!,
                          );
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
  Widget buildTopScorerCard(String name, String subtitle, String imageUrl) {
    return Container(
      width: width*0.38,
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
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              height: height*0.045,
              width: width*0.7,
              decoration: BoxDecoration(
                  // color: secondary,
                  border: Border.all(color: tertiary),
                  borderRadius: const BorderRadius.all(Radius.circular(25))
              ),
              child:  const Text(
                'Follow',
                style: TextStyle(
                  fontSize: 16,
                  color: tertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle follow button press
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.white,
            //     onPrimary: Colors.purple,
            //     side: BorderSide(color: Colors.purple),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 12),
            //     child: Text(
            //       'Follow',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';

import '../../res/custom_back_button.dart';

class AddaScreen extends StatefulWidget {
  const AddaScreen({super.key});

  @override
  State<AddaScreen> createState() => _AddaScreenState();
}

class _AddaScreenState extends State<AddaScreen> {
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
      backgroundColor: appBarColor,
      appBar:AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 220,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Adda",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          shrinkWrap: false,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Top Players(Past 7 days)",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "LAST UPDATE TODAY,12:00 AM",
              style: TextStyle(
                  fontSize: 10, color: labelColor, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height*0.02),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Text("😎"),
                            ),
                            // Icon(Icons.ac_unit),
                            Spacer(),
                            Text(
                              'VIEW ALL',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: tertiary),
                            ),
                            Icon(
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
                         SizedBox(height: height*0.02),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            SizedBox(
                              // width: width,
                              height: height * 0.14,
                              child:addaList(),
                            )
                          ]),
                        ),
                        SizedBox(height: height*0.03,),
                        const Divider()
                        // Section(
                        //   title: 'Ludo Supreme League Maukebaaz',
                        //   players: [
                        //     Player(rank: 'RANK #1', name: 'Cash', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #2', name: 'Kailash gurjar', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #3', name: 'har har mahadev', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #4', name: 'amrendra kumar', image: 'assets/images/zupee.png'),
                        //   ],
                        // ),
                        // SizedBox(height: 16),
                        // Section(
                        //   title: 'Mahasangram Winners',
                        //   players: [
                        //     Player(rank: 'RANK #1', name: 'Yogesh lodhi', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #2', name: 'Campaion', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #3', name: 'ROHITSTAR', image: 'assets/images/zupee.png'),
                        //     Player(rank: 'RANK #4', name: 'Sam', image: 'assets/images/zupee.png'),
                        //   ],
                        // ),
                      ],
                    );
                  }),
            ),
            SizedBox(height: height*0.03,),
            Text("Top players for you to follow",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: black),),
            SizedBox(height: height*0.03,),
            SizedBox(
              height: height*0.24,
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
    );
  }

  Widget addaList() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 100,

            // margin: EdgeInsets.only(right: 16.0),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/zupee.png'),
                ),
                SizedBox(height: 8),
                Text(
                  'RANK #1',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Cash', overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        });
  }
  Widget buildTopScorerCard(String name, String subtitle, String imageUrl) {
    return Container(
      width: width*0.4,
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

// class Section extends StatelessWidget {
//   final String title;
//   final List<Player> players;
//
//   Section({super.key, required this.title, required this.players});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(height: 8),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: players.map((player) {
//               return PlayerCard(player: player);
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class PlayerCard extends StatelessWidget {
//   final Player player;
//
//   PlayerCard({super.key, required this.player});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       margin: EdgeInsets.only(right: 16.0),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage(player.image),
//           ),
//           SizedBox(height: 8),
//           Text(
//             player.rank,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(player.name, overflow: TextOverflow.ellipsis),
//         ],
//       ),
//     );
//   }
// }
//
// class Player {
//   final String rank;
//   final String name;
//   final String image;
//
//   Player({required this.rank, required this.name, required this.image});
// }

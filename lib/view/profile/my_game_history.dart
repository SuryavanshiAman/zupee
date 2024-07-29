import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:zupee/main.dart";
import "package:zupee/res/app_colors.dart";
import "package:zupee/res/custom_back_button.dart";

import "../../generated/assets.dart";

class GameHistoryScreen extends StatefulWidget {
  const GameHistoryScreen({super.key});

  @override
  State<GameHistoryScreen> createState() => _GameHistoryScreenState();
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 220,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "My Game History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),

      ),
      body: Column(
        children: [
          SizedBox(height: height*0.04,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width*0.4,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:white,
                  borderRadius: BorderRadius.circular(18),
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
              Container(
                width: width*0.4,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(18),
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
                        'Total Games Won\n till today',
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
            ],
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(left: 15),
            height: height*0.4,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Games You Played',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: height*0.07,
                        width: width*0.15,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.imagesDice),fit: BoxFit.fill)
                        ),
                      ),
                      SizedBox(width: width*0.03,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ludo Supreme',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            'Games Played: 4',
                            style: TextStyle(
                                fontSize: 12,
                                color: labelColor,
                                // fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            'Games Won: 0',
                            style: TextStyle(
                                fontSize: 12,
                                color: labelColor,
                                // fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

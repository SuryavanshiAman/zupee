import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/view/Game/dice_widgit.dart';
import 'package:zupee/view/Game/ludo_constant.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

import '../../res/app_colors.dart';
import 'board_widgit.dart';
import 'ludo_provider.dart';

class LudoHomeScreen extends StatefulWidget {
  // final int documentId;
  const LudoHomeScreen({super.key});

  @override
  State<LudoHomeScreen> createState() => _LudoHomeScreenState();
}

class _LudoHomeScreenState extends State<LudoHomeScreen> {
  static const maxSeconds = 300; // 5 minutes = 300 seconds
  int _remainingSeconds = maxSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // firestore = FirebaseFirestore.instance;
    // ludoCollection = firestore.collection('ludo');
    startTimer();
  }
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  String user1 = '';
  String user2 = '';
  String user3 = '';
  String user4 = '';
  String key = '';
  @override
  Widget build(BuildContext context) {
    CollectionReference ludoCollection = FirebaseFirestore.instance.collection('ludo');
    String argument = ModalRoute.of(context)!.settings.arguments.toString();
    print("amanArg$argument");
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          // Replace '1' with the specific document ID you want to listen to
          stream: ludoCollection.doc(argument).snapshots(),
          builder: ( context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
            }else{
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('No data available');
            }

            // Fetch the data and display it
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            return _buildDynamicContent(context, data);
          },
        ),


      ),
    );
  }


  Widget _buildDynamicContent(BuildContext context, Map<String, dynamic> data) {
    Map<String, dynamic> player1Data = data['1'].isNotEmpty ? json.decode(data['1']) : {};
    Map<String, dynamic> player2Data = data['2'].isNotEmpty ? json.decode(data['2']) : {};
    Map<String, dynamic> player3Data = data['3'].isNotEmpty ? json.decode(data['3']) : {};
    Map<String, dynamic> player4Data = data['4'].isNotEmpty ? json.decode(data['4']) : {};

    // Build the dynamic content using the parsed data
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesLudoHomeBg),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: width * 0.1,
              ),
              Container(
                  height: height * 0.07,
                  width: width * 0.45,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoPrizePool),
                          fit: BoxFit.fill)),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Prize Pool",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11),
                        ),
                      ),
                      Text(
                        "₹20",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ],
                  )),
              SizedBox(
                width: width * 0.14,
              ),
              SizedBox(
                  height: height * 0.04,
                  child:
                  const Image(image: AssetImage(Assets.ludoSetting))),
              SizedBox(
                width: width * 0.03,
              )
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 2,right: 2),
              height: height * 0.033,
              width: width * 0.24,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                      image: AssetImage(Assets.ludoLabelSection),
                      fit: BoxFit.fill)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.watch_later_outlined,color: white,size: 19,),
                  // Text(timerText.toString(),
                  //     style: const TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 20)),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: height * 0.03,
                  width: width * 0.23,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoLabelSection),
                          fit: BoxFit.fill)),
                  child:  Text(
                      player1Data['name'].toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))),
              Image(
                image: const AssetImage(
                  Assets.ludoInfo,
                ),
                height: height * 0.03,
                width: width * 0.08,
                fit: BoxFit.fill,
              ),
              const Spacer(),
              Image(
                image: const AssetImage(
                  Assets.ludoInfo,
                ),
                height: height * 0.03,
                width: width * 0.08,
                fit: BoxFit.fill,
              ),
              Container(
                  alignment: Alignment.center,
                  height: height * 0.03,
                  width: width * 0.23,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoLabelSectionTwo),
                          fit: BoxFit.fill)),
                  child:  Text(
                      player2Data['name'] ?? 'No Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))),
            ],
          ),
          Padding(
            padding:  const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                userDiceDesign(),
                // Container(
                //     height: height * 0.07,
                //     width: width * 0.15,
                //     decoration: const BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage(Assets.ludoProfileSection))),
                //     child: Image(
                //       image: const AssetImage(
                //         Assets.ludoUser,
                //       ),
                //       height: height * 0.03,
                //       width: width * 0.23,
                //       fit: BoxFit.fill,
                //     )),
                // Container(
                //     alignment: Alignment.center,
                //     height: height * 0.08,
                //     width: width * 0.19,
                //     decoration: const BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage(Assets.ludoDiceSectionOne),
                //             fit: BoxFit.fill)),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Image(
                //         image: const AssetImage(
                //           Assets.ludoDice,
                //         ),
                //         height: height * 0.06,
                //         width: width * 0.17,
                //       ),
                //     )),
                const Spacer(),
                opponentsTurn(),
                // Container(
                //     alignment: Alignment.center,
                //     height: height * 0.08,
                //     width: width * 0.19,
                //     decoration: const BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage(Assets.ludoDiceSectionTwo),
                //             fit: BoxFit.fill)),
                //     child: Padding(
                //       padding: const EdgeInsets.only(right: 8.0),
                //       child: Image(
                //         image: const AssetImage(
                //           Assets.ludoDice,
                //         ),
                //         height: height * 0.06,
                //         width: width * 0.17,
                //       ),
                //     )),
                // Container(
                //     height: height * 0.07,
                //     width: width * 0.15,
                //     decoration: const BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage(Assets.ludoProfileSection))),
                //     child: Image(
                //       image: const AssetImage(
                //         Assets.ludoUser,
                //       ),
                //       height: height * 0.03,
                //       width: width * 0.23,
                //       fit: BoxFit.fill,
                //     )),
              ],
            ),
          ),
          const BoardWidget(),
          // Center(
          //   child: Container(
          //     width: width,
          //     height: height * 0.5,
          //     decoration: const BoxDecoration(
          //         image: DecorationImage(
          //             image: AssetImage(Assets.ludoLudoBoard),
          //             fit: BoxFit.cover)),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         decoration: const BoxDecoration(
          //             image: DecorationImage(
          //                 image: AssetImage(Assets.ludoBoardTwo))),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.ludoProfileSection))),
                    child: Image(
                      image: const AssetImage(
                        Assets.ludoUser,
                      ),
                      height: height * 0.03,
                      width: width * 0.23,
                      fit: BoxFit.fill,
                    )),
                Container(
                    alignment: Alignment.center,
                    height: height * 0.08,
                    width: width * 0.19,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.ludoDiceSectionOne),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image(
                        image: const AssetImage(
                          Assets.ludoDice,
                        ),
                        height: height * 0.06,
                        width: width * 0.17,
                      ),
                    )),
                const Spacer(),
                Container(
                    alignment: Alignment.center,
                    height: height * 0.08,
                    width: width * 0.19,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.ludoDiceSectionTwo),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image(
                        image: const AssetImage(
                          Assets.ludoDice,
                        ),
                        height: height * 0.06,
                        width: width * 0.17,
                      ),
                    )),
                Container(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.ludoProfileSection))),
                    child: Image(
                      image: const AssetImage(
                        Assets.ludoUser,
                      ),
                      height: height * 0.03,
                      width: width * 0.23,
                      fit: BoxFit.fill,
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: height * 0.03,
                  width: width * 0.23,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoLabelSection),
                          fit: BoxFit.fill)),
                  child:  Text(player3Data['name'] ?? 'No Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))),
              Image(
                image: const AssetImage(
                  Assets.ludoInfo,
                ),
                height: height * 0.03,
                width: width * 0.08,
                fit: BoxFit.fill,
              ),
              const Spacer(),
              Image(
                image: const AssetImage(
                  Assets.ludoInfo,
                ),
                height: height * 0.03,
                width: width * 0.08,
                fit: BoxFit.fill,
              ),
              Container(
                  alignment: Alignment.center,
                  height: height * 0.03,
                  width: width * 0.23,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.ludoLabelSectionTwo),
                          fit: BoxFit.fill)),
                  child:  Text(
                      player4Data['name'] ?? 'No Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }
  Widget userDiceDesign() {
    return Consumer<LudoProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(bottom:0, left:  0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
            height: height * 0.07,
            width: width * 0.15,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.ludoProfileSection))),
            child: Image(
              image: const AssetImage(
                Assets.ludoUser,
              ),
              height: height * 0.03,
              width: width * 0.23,
              fit: BoxFit.fill,
            )),
          value.currentPlayer.type !=LudoPlayerType.yellow?const DiceWidget():
          Container(
              alignment: Alignment.center,
              height: height * 0.08,
              width: width * 0.19,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.ludoDiceSectionOne),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image(
                  image: const AssetImage(
                    Assets.ludoDice,
                  ),
                  height: height * 0.06,
                  width: width * 0.17,
                ),
              ))
              ,
            ]),
      ),
    );
  }

  bool isUserTurn = true;
  Widget opponentsTurn() {
    return Consumer<LudoProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            value.currentPlayer.type ==LudoPlayerType.yellow?const DiceWidget():
            Container(
                alignment: Alignment.center,
                height: height * 0.08,
                width: width * 0.19,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.ludoDiceSectionOne),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image(
                    image: const AssetImage(
                      Assets.ludoDice,
                    ),
                    height: height * 0.06,
                    width: width * 0.17,
                  ),
                )),
            Container(
                height: height * 0.07,
                width: width * 0.15,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.ludoProfileSection))),
                child: Image(
                  image: const AssetImage(
                    Assets.ludoUser,
                  ),
                  height: height * 0.03,
                  width: width * 0.23,
                  fit: BoxFit.fill,
                )),
          ],
        );
      },
    );
  }
}

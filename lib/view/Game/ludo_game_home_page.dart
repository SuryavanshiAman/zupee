import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/image_tost.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/bot/bot_player.dart';
import 'package:zupee/view/Game/dice_widgit.dart';
import 'package:zupee/view/Game/ludo_constant.dart';
import 'package:zupee/view_model/firebase_view_model.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/timer_view_model.dart';
import '../../res/app_colors.dart';
import 'board_widgit.dart';
import 'ludo_provider.dart';

class LudoHomeScreen extends StatefulWidget {
  final String? amount;
  const LudoHomeScreen({super.key, this.amount});

  @override
  State<LudoHomeScreen> createState() => _LudoHomeScreenState();
}

class _LudoHomeScreenState extends State<LudoHomeScreen> {
  TimerProvider timerProvider = TimerProvider();
  LudoProvider ludoProvider = LudoProvider();
  bool showContainer=false;
  @override
  void initState() {
    super.initState();
    Provider.of<LudoProvider>(context, listen: false).listenToGameUpdates(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageToast();
      String argument = ModalRoute.of(context)!.settings.arguments.toString();
      timerProvider.setAmount(argument);
    });
    Future.delayed(const Duration(seconds: 5), () {
      timerProvider.startTimer(context);
      setState(() {
        showContainer = true;
      });
    });
  }

  void imageToast() {
    ImageToast.show(
      imagePath: Assets.imagesTextArea,
      height: height * 0.08,
      width: width * 0.6,
      context: context,
      text: "Game will start after 5 sec",
    );
  }

  Future<bool> _onWillPop() async {
    return await Utils.exitGame(context, timerProvider, ludoProvider) ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool timerAndTost = false;
  @override
  Widget build(BuildContext context) {
    final documentID = Provider.of<FirebaseViewModel>(context);
    final docId = documentID.table.toString();
    CollectionReference ludoCollection =
        FirebaseFirestore.instance.collection('ludo');
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        _onWillPop();
      },
      child: SafeArea(
        child: Scaffold(
            body: StreamBuilder<DocumentSnapshot>(
          stream: ludoCollection.doc(docId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Stack(
                children: [_buildDynamicContent(context, data),
                  if (!showContainer)
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.5),  // Use proper opacity
                    ),
                ]);
          },
        )),
      ),
    );
  }

  Widget _buildDynamicContent(BuildContext context, Map<String, dynamic> data) {
    final profile = Provider.of<ProfileViewModel>(context,listen: false).profileResponse;
    final ludoProvider = Provider.of<LudoProvider>(context);
    Map<String, dynamic> player1Data =
        (data['1'] != null && data['1'].isNotEmpty)
            ? json.decode(data['1'])
            : {};
    Map<String, dynamic> player2Data =
        (data['2'] != null && data['2'].isNotEmpty)
            ? json.decode(data['2'])
            : {};
    Map<String, dynamic> player3Data =
        (data['3'] != null && data['3'].isNotEmpty)
            ? json.decode(data['3'])
            : {};
    Map<String, dynamic> player4Data =
        (data['4'] != null && data['4'].isNotEmpty)
            ? json.decode(data['4'])
            : {};

    final List<Map<String, dynamic>> playerData = [
      player1Data,
      player2Data,
      player3Data,
      player3Data
    ];

    return Stack(
      children: [


        Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesLudoHomeBg), fit: BoxFit.fill)),
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
                      child: Column(
                        children: [
                          const Padding(
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
                            "₹${timerProvider.amount.toString()}",
                            style: const TextStyle(
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
                      child: const Image(image: AssetImage(Assets.ludoSetting))),
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
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  height: height * 0.033,
                  width: width * 0.24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                          image: AssetImage(Assets.ludoLabelSection),
                          fit: BoxFit.fill)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: white,
                        size: 19,
                      ),
                      Text(timerProvider.timerText.toString(),
                          style: const TextStyle(
                              color: green,
                              fontFamily: "digital",
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
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
                      child: Text( profile?.data?.id.toString()==player3Data['id'] ? player1Data['name']: player3Data['name']??"",
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
                  ludoProvider.playerQuantity != 2
                      ? Image(
                          image: const AssetImage(
                            Assets.ludoInfo,
                          ),
                          height: height * 0.03,
                          width: width * 0.08,
                          fit: BoxFit.fill,
                        )
                      : Container(),
                  ludoProvider.playerQuantity != 2
                      ? Container(
                          alignment: Alignment.center,
                          height: height * 0.03,
                          width: width * 0.23,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.ludoLabelSectionTwo),
                                  fit: BoxFit.fill)),
                          child: Text(player2Data['name'] ?? 'No Name',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)))
                      : Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    userDiceDesign(playerData,data),
                    const Spacer(),
                    ludoProvider.playerQuantity != 2
                        ? opponentsOneTurn(playerData)
                        : Container(),

                  ],
                ),
              ),
              BoardWidget(playerData: playerData),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    ludoProvider.playerQuantity != 2
                        ? opponentsTwoTurn(playerData)
                        : Container(),
                    const Spacer(),
                    opponentsThreeTurn(playerData,data),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ludoProvider.playerQuantity != 2
                      ? Container(
                          alignment: Alignment.center,
                          height: height * 0.03,
                          width: width * 0.23,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.ludoLabelSection),
                                  fit: BoxFit.fill)),
                          child: Text(player4Data['name'] ?? 'No Name',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)))
                      : Container(),
                  ludoProvider.playerQuantity != 2
                      ? Image(
                          image: const AssetImage(
                            Assets.ludoInfo,
                          ),
                          height: height * 0.03,
                          width: width * 0.08,
                          fit: BoxFit.fill,
                        )
                      : Container(),
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
                      child: Text(
                          profile?.data?.id.toString()==player3Data['id'] ? player3Data['name']:profile?.data?.id.toString()==player1Data['id'] ? player1Data['name']:profile?.data?.id.toString()==player2Data['id'] ? player2Data['name']:player4Data['name']??profile?.data?.id.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
        // timerProvider.remainingSeconds.toString()=="0"? Container(height: height,width: width,color: Colors.black.withOpacity(0.2,)):Container(),

        // timerProvider.remainingSeconds.toString()=="0"?(int.parse(profile?.data?.id.toString()??"").toString() == int.parse(ludoProvider.firstPlace?.name['id']).toString()?Image.asset(Assets.gifCongratulation):Container()):Container(),
        // timerProvider.remainingSeconds.toString()=="0"?(int.parse(profile?.data?.id.toString()??"").toString() == int.parse(ludoProvider.firstPlace?.name['id']).toString()?Center(child: Lottie.asset(Assets.lottieWinner,)):Container()):Container(),

      ],
    );
  }

  Widget userDiceDesign(List<Map<String, dynamic>> playerData,data) {
    final profile = Provider.of<ProfileViewModel>(context,listen: false).profileResponse;
    Map<String, dynamic> player1Data =
    (data['1'] != null && data['1'].isNotEmpty)
        ? json.decode(data['1'])
        : {};
    Map<String, dynamic> player2Data =
    (data['2'] != null && data['2'].isNotEmpty)
        ? json.decode(data['2'])
        : {};
    Map<String, dynamic> player3Data =
    (data['3'] != null && data['3'].isNotEmpty)
        ? json.decode(data['3'])
        : {};
    Map<String, dynamic> player4Data =
    (data['4'] != null && data['4'].isNotEmpty)
        ? json.decode(data['4'])
        : {};

    return Consumer<LudoProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

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
              // value.currentPlayer.type.toString() == player1Data['color'].toString()||
              //     value.currentPlayer.type.toString() == player2Data['color'].toString()||
              //     value.currentPlayer.type.toString() == player3Data['color'].toString()||
              //     value.currentPlayer.type.toString() == player4Data['color'].toString()
              profile?.data?.id.toString()==player3Data['id']
              ?
              DiceWidget(playerData: playerData)
              :Container(
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
        ]),
      ),
    );
  }

  Widget opponentsOneTurn(List<Map<String, dynamic>> playerData) {
    return Consumer<LudoProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            value.currentPlayer.type == LudoPlayerType.red
                ? DiceWidget(playerData: playerData)
                : Container(
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

  Widget opponentsTwoTurn(List<Map<String, dynamic>> playerData) {
    return Consumer<LudoProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            value.currentPlayer.type == LudoPlayerType.yellow
                ? DiceWidget(playerData: playerData)
                : Container(
                    alignment: Alignment.center,
                    height: height * 0.08,
                    width: width * 0.19,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.ludoDiceSectionOne),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Image(
                        image: const AssetImage(
                          Assets.ludoDice,
                        ),
                        height: height * 0.06,
                        width: width * 0.17,
                      ),
                    )),
          ],
        );
      },
    );
  }

  Widget opponentsThreeTurn(List<Map<String, dynamic>> playerData,data) {
    Map<String, dynamic> player1Data =
    (data['1'] != null && data['1'].isNotEmpty)
        ? json.decode(data['1'])
        : {};
    Map<String, dynamic> player2Data =
    (data['2'] != null && data['2'].isNotEmpty)
        ? json.decode(data['2'])
        : {};
    Map<String, dynamic> player3Data =
    (data['3'] != null && data['3'].isNotEmpty)
        ? json.decode(data['3'])
        : {};
    Map<String, dynamic> player4Data =
    (data['4'] != null && data['4'].isNotEmpty)
        ? json.decode(data['4'])
        : {};

    return Consumer<LudoProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // value.currentPlayer.type == LudoPlayerType.green
            value.currentPlayer.type.toString() == player1Data['color'].toString()||
                value.currentPlayer.type.toString() == player2Data['color'].toString()||
                value.currentPlayer.type.toString() == player3Data['color'].toString()||
                value.currentPlayer.type.toString() == player4Data['color'].toString()
                ? DiceWidget(playerData: playerData)
                : Container(
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

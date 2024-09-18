import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/launcher.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/profile_view_model.dart';

import '../../generated/assets.dart';
import '../../view_model/send_result_view_model.dart';
import 'ludo_provider.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {

  String maskNumber(number) {
    if (number.length < 2) {
      return number;
    }
    String firstPart = number.substring(0, 2);
    String lastPart = number.substring(number.length - 2);
    String maskedPart = 'x' * (number.length - 4);
    return '$firstPart$maskedPart$lastPart';
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final profile = Provider.of<ProfileViewModel>(context,listen: false).profileResponse;
      final ludoProvider = Provider.of<LudoProvider>(context,listen: false);
      ludoProvider.setMyData(profile);
      ludoProvider.setMyPosition(profile);
      final sendResultViewModel=Provider.of<SendResultViewModel>(context,listen: false);
      sendResultViewModel.sendResultApi(ludoProvider.tournamentId.toString(), ludoProvider.myPosition.toString(), ludoProvider.myData['score'].toString(), context);
    });

  }

  @override
  Widget build(BuildContext context) {
    String argument = ModalRoute.of(context)!.settings.arguments.toString();
    final ludoProvider = Provider.of<LudoProvider>(context);
    final profile = Provider.of<ProfileViewModel>(context).profileResponse;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Color(0xff1e2283)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: height * 0.5,
                  width: width * 0.6,
                  child: Image.asset(
                    Assets.imagesStx,
                    fit: BoxFit.fill,
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * 0.1),
                      height: height * 0.37,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: lightBlueTwo,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.07,
                          ),
                          int.parse(profile!.data!.id.toString()).toString() ==
                                  int.parse(ludoProvider.firstPlace?.name['id'])
                                      .toString()
                              ? Container(
                                  alignment: Alignment.center,
                                  height: height * 0.04,
                                  width: width * 0.18,
                                  decoration: BoxDecoration(
                                      color: black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    "WINNER",
                                    style: TextStyle(
                                        color: cream,
                                        fontWeight: FontWeight.w500),
                                  ))
                              : Container(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            int.parse(profile.data!.id.toString()).toString() ==
                                    int.parse(
                                            ludoProvider.firstPlace?.name['id'])
                                        .toString()
                                ? "You have won ₹$argument"
                                : "You have lost the match",
                            style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              const Text(
                                "Score",
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              const Text(
                                "Prize",
                                style: TextStyle(
                                    color: cream,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                              SizedBox(
                                width: width * 0.08,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: height * 0.005,
                          // ),
                          Consumer<LudoProvider>(
                            builder: (context, ludoProvider, child) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  var player =
                                      ludoProvider.playerDataList[index];
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      margin: EdgeInsets.only(bottom: 4),
                                      height: height * 0.055,
                                      width: width * 0.78,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: white, width: 1),
                                          color: blue,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25.0, top: 9),
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * 0.12,
                                                    height: height * 0.025,
                                                    decoration:
                                                        const BoxDecoration(
                                                            // shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    Assets
                                                                        .imagesFirsrt),
                                                                fit:
                                                                    BoxFit.fill)),
                                                    child: Text(
                                                        "${index + 1}${index == 0 ? 'st' : 'nd'}",
                                                        style: const TextStyle(
                                                            color: cream,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13))),
                                              ),
                                              Container(
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage(Assets
                                                              .ludoProfileSection))),
                                                  child: Image.asset(
                                                    Assets.ludoUser,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Text(
                                              "+91${maskNumber(player['name']['number'])}",
                                              style: const TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)),
                                          SizedBox(
                                            width: width * 0.04,
                                          ),
                                          Text(player['score'].toString(),
                                              style: const TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16)),
                                          SizedBox(
                                            width: width * 0.1,
                                          ),
                                           Text("₹$argument",
                                              style: const TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: int.parse(profile.data!.id.toString())
                                      .toString() ==
                                  int.parse(ludoProvider.firstPlace?.name['id'])
                                      .toString()
                              ? height * 0.03
                              : height * 0.0),
                      child: Image.asset(
                        ludoProvider.playerQuantity!=2?
                        (  int.parse(profile.data!.id.toString()).toString() == int.parse(ludoProvider.firstPlace?.name['id']).toString()
                              ? Assets.ludoCrown:
                          int.parse(profile.data!.id.toString()).toString() == int.parse(ludoProvider.secondPlace?.name['id']).toString()?Assets.imagesSecondRank
                              : Assets.imagesLoos):int.parse(profile.data!.id.toString()).toString() == int.parse(ludoProvider.firstPlace?.name['id']).toString()
                            ? Assets.ludoCrown: Assets.imagesLoos,
                          height: int.parse(profile.data!.id.toString())
                                      .toString() ==
                                  int.parse(ludoProvider.firstPlace?.name['id'])
                                      .toString()
                              ? null
                              : height * 0.25),
                    ),
                  ],
                )
              ],
            ),
            const Text("Share your success!",
                style: TextStyle(
                    color: white, fontWeight: FontWeight.w600, fontSize: 16)),
            SizedBox(
              height: height * 0.01,
            ),

            Container(
                padding: const EdgeInsets.all(4),
                height: height * 0.055,
                width: width * 0.4,
                decoration: BoxDecoration(
                    color: black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(55)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          Launcher.whatsappLaunch();
                        },
                        child: Image.asset(Assets.imagesWhatsapp)),
                    InkWell(
                        onTap: () {
                          Launcher.launchFacebook();
                        },
                        child: Image.asset(Assets.iconFacebok)),
                    InkWell(
                        onTap: () {
                          Share.share('Mai jeet gaya');
                        },
                        child: Image.asset(Assets.imagesShare)),
                  ],
                )),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar,
                    arguments: {"index": 0});
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.07,
                width: width * 0.8,
                decoration: const BoxDecoration(
                    color: Color(0xff1e2283),
                    image: DecorationImage(
                        image: AssetImage(Assets.ludoLobby), fit: BoxFit.fill)),
                child: const Text("GO TO LOBBY",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22)),
              ),
            ),
            SizedBox(
              height: height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}

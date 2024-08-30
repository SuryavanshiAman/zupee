import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/launcher.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../generated/assets.dart';
import 'ludo_provider.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  String number = '7485499624';

  String maskNumber(number) {
    if (number.length < 2)
      return number; // If the number is too short, return as is
    String firstPart = number.substring(0, 2); // First two digits
    String lastPart = number.substring(number.length - 2); // Last two digits
    String maskedPart =
        'x' * (number.length - 4); // Middle part replaced with 'x'
    return '$firstPart$maskedPart$lastPart';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Color(0xff1e2283)
            // image: DecorationImage(
            //     image: AssetImage(Assets.ludoWinnerBg), fit: BoxFit.fill)
            ),
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
                          Container(
                              alignment: Alignment.center,
                              height: height * 0.04,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                  color: black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                "WINNER",
                                style: TextStyle(
                                    color: cream, fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Text(
                            "You have won ₹1.7",
                            style: TextStyle(
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
                          SizedBox(
                            height: height * 0.005,
                          ),
                          // Consumer<LudoProvider>(
                          //   builder: (context, ludoProvider, child) {
                          //     return ListView.builder(
                          //       shrinkWrap: true,
                          //       physics: const NeverScrollableScrollPhysics(),
                          //       itemCount: 2,
                          //       itemBuilder: (context, index) {
                          //         var player =
                          //             ludoProvider.playerDataList[index];
                          //
                          //         return Container(
                          //           padding: const EdgeInsets.all(3),
                          //           height: height * 0.055,
                          //           width: width * 0.8,
                          //           decoration: BoxDecoration(
                          //               border:
                          //                   Border.all(color: white, width: 1),
                          //               color: blue,
                          //               borderRadius: BorderRadius.circular(8)),
                          //           child: Row(
                          //             children: [
                          //               Stack(
                          //                 children: [
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         left: 25.0, top: 9),
                          //                     child: Container(
                          //                         alignment: Alignment.center,
                          //                         width: width * 0.12,
                          //                         height: height * 0.025,
                          //                         decoration:
                          //                             const BoxDecoration(
                          //                                 // shape: BoxShape.circle,
                          //                                 image: DecorationImage(
                          //                                     image: AssetImage(
                          //                                         Assets
                          //                                             .imagesFirsrt),
                          //                                     fit:
                          //                                         BoxFit.fill)),
                          //                         child:  Text("${index + 1}${index == 0 ? 'st' : 'nd'}",
                          //                             style: const TextStyle(
                          //                                 color: cream,
                          //                                 fontWeight:
                          //                                     FontWeight.w600,
                          //                                 fontSize: 13))),
                          //                   ),
                          //                   Container(
                          //                       decoration: const BoxDecoration(
                          //                           shape: BoxShape.circle,
                          //                           image: DecorationImage(
                          //                               image: AssetImage(Assets
                          //                                   .ludoProfileSection))),
                          //                       child: Image.asset(
                          //                         Assets.ludoUser,
                          //                       )),
                          //                 ],
                          //               ),
                          //               SizedBox(
                          //                 width: width * 0.03,
                          //               ),
                          //               Text("+91${maskNumber(number)}",
                          //                   style: const TextStyle(
                          //                       color: white,
                          //                       fontWeight: FontWeight.w600,
                          //                       fontSize: 13)),
                          //               SizedBox(
                          //                 width: width * 0.04,
                          //               ),
                          //               Text(player['score'].toString(),
                          //                   style: const TextStyle(
                          //                       color: white,
                          //                       fontWeight: FontWeight.w600,
                          //                       fontSize: 16)),
                          //               SizedBox(
                          //                 width: width * 0.1,
                          //               ),
                          //               const Text("₹1.7",
                          //                   style: TextStyle(
                          //                       color: white,
                          //                       fontWeight: FontWeight.w600,
                          //                       fontSize: 16)),
                          //             ],
                          //           ),
                          //         );
                          //         //   Container(
                          //         //   padding: const EdgeInsets.all(3),
                          //         //   // margin: const EdgeInsets.symmetric(vertical: 4),
                          //         //   height: MediaQuery.of(context).size.height * 0.055,
                          //         //   width: MediaQuery.of(context).size.width * 0.8,
                          //         //   decoration: BoxDecoration(
                          //         //     border: Border.all(color: Colors.white, width: 1),
                          //         //     color: index == 0 ? blue : Color(0xff1e2283).withOpacity(0.5),
                          //         //     borderRadius: BorderRadius.circular(8),
                          //         //   ),
                          //         //   child: Row(
                          //         //     children: [
                          //         //       Stack(
                          //         //         children: [
                          //         //           Padding(
                          //         //             padding: const EdgeInsets.only(left: 25.0, top: 9),
                          //         //             child: Container(
                          //         //               alignment: Alignment.center,
                          //         //               width:width * 0.12,
                          //         //               height: height * 0.025,
                          //         //               decoration: BoxDecoration(
                          //         //                 image: DecorationImage(
                          //         //                   image: AssetImage( Assets.imagesFirsrt),
                          //         //                   fit: BoxFit.fill,
                          //         //                 ),
                          //         //               ),
                          //         //               child: Text(
                          //         //                 "${index + 1}${index == 0 ? 'st' : 'nd'}",
                          //         //                 style: const TextStyle(color: cream, fontWeight: FontWeight.w600, fontSize: 13),
                          //         //               ),
                          //         //             ),
                          //         //           ),
                          //         //           Container(
                          //         //             decoration: BoxDecoration(
                          //         //               shape: BoxShape.circle,
                          //         //               image: DecorationImage(image: AssetImage(Assets.ludoProfileSection)),
                          //         //             ),
                          //         //             child: Image.asset(Assets.ludoUser),
                          //         //           ),
                          //         //         ],
                          //         //       ),
                          //         //       SizedBox(width: width * 0.03),
                          //         //       Text(
                          //         //         "+91${maskNumber(number)}",
                          //         //         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                          //         //       ),
                          //         //       SizedBox(width: width * 0.09),
                          //         //       Text(
                          //         //         player['score'].toString(),
                          //         //         style: const TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 16),
                          //         //       ),
                          //         //       SizedBox(width: width * 0.1),
                          //         //       const Text(
                          //         //         "₹1.7",
                          //         //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                          //         //       ),
                          //         //     ],
                          //         //   ),
                          //         // );
                          //       },
                          //     );
                          //   },
                          // ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: height * 0.055,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: white, width: 1),
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
                                          decoration: const BoxDecoration(
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Assets.imagesFirsrt),
                                                  fit: BoxFit.fill)),
                                          child: const Text("1st",
                                              style: TextStyle(
                                                  color: cream,
                                                  fontWeight: FontWeight.w600,
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
                                Text("+91${maskNumber(number)}",
                                    style: const TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                                const Text("273",
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                const Text("₹1.7",
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: height * 0.055,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: white, width: 1),
                                color: const Color(0xff1e2283).withOpacity(0.5),
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
                                          decoration: const BoxDecoration(
                                              // shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Assets.imagesFirsrt),
                                                  fit: BoxFit.fill)),
                                          child: const Text("2nd",
                                              style: TextStyle(
                                                  color: cream,
                                                  fontWeight: FontWeight.w600,
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
                                Text("+91${maskNumber(number)}",
                                    style: const TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                                const Text("273",
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                const Text("₹1.7",
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: Image.asset(Assets.ludoCrown),
                    ),
                  ],
                )
              ],
            ),
            //
            const Text("Share your success!",
                style: TextStyle(
                    color: white, fontWeight: FontWeight.w600, fontSize: 16)),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
                padding: const EdgeInsets.all(4),
                // margin: EdgeInsets.only(top: height*0.1),
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
            Spacer(),
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
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:zupee/main.dart';
// import 'package:zupee/res/app_colors.dart';
// import 'package:zupee/res/launcher.dart';
// import 'package:zupee/utils/routes_name.dart';
//
// import '../../generated/assets.dart';
// import 'ludo_provider.dart';
//
// class WinnerScreen extends StatefulWidget {
//   const WinnerScreen({super.key});
//
//   @override
//   State<WinnerScreen> createState() => _WinnerScreenState();
// }
//
// class _WinnerScreenState extends State<WinnerScreen> {
//   String number = '7485499624';
//
//   String maskNumber(String number) {
//     if (number.length < 2) return number; // If the number is too short, return as is
//     String firstPart = number.substring(0, 2); // First two digits
//     String lastPart = number.substring(number.length - 2); // Last two digits
//     String maskedPart = 'x' * (number.length - 4); // Middle part replaced with 'x'
//     return '$firstPart$maskedPart$lastPart';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height:height,
//         width: width,
//         decoration: const BoxDecoration(
//           color: Color(0xff1e2283),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: height * 0.03),
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   alignment: Alignment.topCenter,
//                   height: height * 0.5,
//                   width:width * 0.6,
//                   child: Image.asset(Assets.imagesStx, fit: BoxFit.fill),
//                 ),
//                 Stack(
//                   alignment: AlignmentDirectional.topCenter,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: height * 0.1),
//                       height:height * 0.37,
//                       width: width * 0.9,
//                       decoration: BoxDecoration(
//                           color: lightBlueTwo, // lightBlueTwo
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(height:height * 0.07),
//                           Container(
//                             alignment: Alignment.center,
//                             height:height * 0.04,
//                             width: width * 0.18,
//                             decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: const Text(
//                               "WINNER",
//                               style: TextStyle(color:cream, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           SizedBox(height:height * 0.01),
//                           const Text(
//                             "You have won ₹1.7",
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
//                           ),
//                           SizedBox(height:height * 0.025),
//                           Row(
//                             children: [
//                               const Spacer(),
//                               const Text(
//                                 "Score",
//                                 style: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 13),
//                               ),
//                               SizedBox(width:width * 0.1),
//                               const Text(
//                                 "Prize",
//                                 style: TextStyle(color: cream, fontWeight: FontWeight.w600, fontSize: 13),
//                               ),
//                               SizedBox(width:width * 0.08),
//                             ],
//                           ),
//                           SizedBox(height: height * 0.005),
//                           _buildPlayerData(context),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top:height * 0.03),
//                       child: Image.asset(Assets.ludoCrown),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Text(
//               "Share your success!",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//             _buildShareButtons(),
//             const Spacer(),
//             InkWell(
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar, arguments: {"index": 0});
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 decoration: const BoxDecoration(
//                   color: Color(0xff1e2283),
//                   image: DecorationImage(image: AssetImage(Assets.ludoLobby), fit: BoxFit.fill),
//                 ),
//                 child: const Text(
//                   "GO TO LOBBY",
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlayerData(BuildContext context) {
//     return Consumer<LudoProvider>(
//       builder: (context, ludoProvider, child) {
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 2,
//           itemBuilder: (context, index) {
//             var player = ludoProvider.playerDataList[index];
//
//             return Container(
//               padding: const EdgeInsets.all(3),
//               // margin: const EdgeInsets.symmetric(vertical: 4),
//               height: MediaQuery.of(context).size.height * 0.055,
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 1),
//                 color: index == 0 ? blue : Color(0xff1e2283).withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 25.0, top: 9),
//                         child: Container(
//                           alignment: Alignment.center,
//                           width:width * 0.12,
//                           height: height * 0.025,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage( Assets.imagesFirsrt),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           child: Text(
//                             "${index + 1}${index == 0 ? 'st' : 'nd'}",
//                             style: const TextStyle(color: cream, fontWeight: FontWeight.w600, fontSize: 13),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(image: AssetImage(Assets.ludoProfileSection)),
//                         ),
//                         child: Image.asset(Assets.ludoUser),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: width * 0.03),
//                   Text(
//                     "+91${maskNumber(number)}",
//                     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
//                   ),
//                   SizedBox(width: width * 0.09),
//                   Text(
//                     player['score'].toString(),
//                     style: const TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   SizedBox(width: width * 0.1),
//                   const Text(
//                     "₹1.7",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//   // Container(
//   // padding: EdgeInsets.all(3),
//   // height: height*0.055,
//   // width: width*0.8,
//   // decoration: BoxDecoration(
//   // border: Border.all(color: white,width: 1),
//   // color: blue, borderRadius: BorderRadius.circular(8)),
//   // child: Row(
//   // children: [
//   //
//   // Stack(
//   // children: [
//   // Padding(
//   // padding: const EdgeInsets.only(left: 25.0,top: 9),
//   // child: Container(
//   // alignment: Alignment.center,
//   // width: width*0.12,
//   // height: height*0.025,
//   // decoration: BoxDecoration(
//   // // shape: BoxShape.circle,
//   // image: DecorationImage(image: AssetImage(Assets.imagesFirsrt),fit: BoxFit.fill)
//   // ),
//   // child: Text("1st",style: TextStyle(color: cream,fontWeight: FontWeight.w600,fontSize:13 ))
//   // ),
//   // ),
//   // Container(
//   //
//   // decoration: BoxDecoration(
//   // shape: BoxShape.circle,
//   // image: DecorationImage(image: AssetImage(Assets.ludoProfileSection))
//   // ),
//   // child: Image.asset(Assets.ludoUser,)),
//   // ],
//   // ),
//   // SizedBox(width: width*0.03,),
//   // Text("+91${maskNumber(number)}",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:13 )),
//   // SizedBox(width: width*0.04,),
//   // Text("273",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),
//   // SizedBox(width: width*0.1,),
//   // Text("₹1.7",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),
//   //
//   //
//   // ],
//   // ),
//   //
//   // ),
//   Widget _buildShareButtons() {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       height: MediaQuery.of(context).size.height * 0.055,
//       width: MediaQuery.of(context).size.width * 0.4,
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.4),
//         borderRadius: BorderRadius.circular(55),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           InkWell(
//             onTap: () {
//               Launcher.whatsappLaunch();
//             },
//             child: Image.asset(Assets.imagesWhatsapp),
//           ),
//           InkWell(
//             onTap: () {
//               Launcher.launchFacebook();
//             },
//             child: Image.asset(Assets.iconFacebok),
//           ),
//           InkWell(
//             onTap: () {
//               Share.share('Mai jeet gaya');
//             },
//             child: Image.asset(Assets.imagesShare),
//           ),
//         ],
//       ),
//     );
//   }
// }

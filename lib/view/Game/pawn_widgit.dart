// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
//
// import '../../res/app_colors.dart';
// import 'ludo_constant.dart';
// import 'ludo_provider.dart';
//
// ///Widget for the pawn
// class PawnWidget extends StatelessWidget {
//   final int index;
//   final LudoPlayerType type;
//    final int step;
//   final bool highlight;
//   final int ?initialStep;
//
//   const PawnWidget(this.index, this.type, {Key? key, this.highlight = false, this.step = -0,this.initialStep}) : super(key: key);
//   int get stepsMoved => (step >= 0 && initialStep != null) ? (step - initialStep!) : 0;
//   @override
//   Widget build(BuildContext context) {
//
//
//     Color color = Colors.white;
//     switch (type) {
//     case LudoPlayerType.blue:
//       color = LudoColor.blue;
//       break;
//       case LudoPlayerType.red:
//         color = LudoColor.red;
//         break;
//       case LudoPlayerType.green:
//         color = LudoColor.green;
//         break;
//       case LudoPlayerType.yellow:
//         color = LudoColor.yellow;
//         break;
//
//
//     }
//
//     String pown = Assets.diceYellowPawn;
//     switch (type) {
//     case LudoPlayerType.blue:
//       pown = "Assets.diceBluepawn";
//       break;
//       case LudoPlayerType.red:
//         pown = Assets.diceRedPawn;
//         break;
//       case LudoPlayerType.green:
//         pown = "Assets.diceGreenpawn";
//         break;
//       case LudoPlayerType.yellow:
//         pown = Assets.diceYellowPawn;
//         break;
//
//
//     }
//
//     return IgnorePointer(
//       ignoring: !highlight,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (highlight)
//             const RippleAnimation(
//               color: white,
//               minRadius: 20,
//               repeat: true,
//               ripplesCount: 3,
//               child: SizedBox.shrink(),
//             ),
//           Consumer<LudoProvider>(
//             builder: (context, provider, child) => GestureDetector(
//               onTap: () {
//                 // if (step == -1) {
//                 //   provider.move(type, index, (step + 1) + 1);
//                 // } else {
//                 //   provider.move(type, index, (step + 1) + provider.diceResult);
//                 // }
//                 // context.read<LudoProvider>().move(type, index, step);
//                 if (provider.diceResult > 0) {
//                   int nextStep = step == -1 ? 1 : step + provider.diceResult;
//                   provider.move(type, index, nextStep);
//                 }
//               },
//               child: Stack(
//                   children: [
//                     SizedBox(height: height*0.01,),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 5.0),
//                       child: Transform.scale(
//                         scale: 2.5,
//                         child: Image.asset(pown),
//                       ),
//                     ),
//                   ]
//               ),
//
//             ),
//           ),
//         ],
//
//       ),
//
//     );
//   }
// }
/// latest working 23-08
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

import '../../res/app_colors.dart';
import 'ludo_constant.dart';
import 'ludo_provider.dart';

class PawnWidget extends StatefulWidget {
  final int index;
  final LudoPlayerType type;
  int step;
  final bool highlight;
  final int? initialStep;

  PawnWidget(this.index, this.type,  {Key? key, this.highlight = false, this.step = 0, this.initialStep}) : super(key: key);
  int get stepsMoved => (step >= 0 && initialStep != null) ? (step - initialStep!) : 0;
  @override
  State<PawnWidget> createState() => _PawnWidgetState();
}

class _PawnWidgetState extends State<PawnWidget> {
  late String pawnAsset;
  FirebaseViewModel firebaseViewModel =FirebaseViewModel();
  late DocumentReference<Map<String, dynamic>> gameDoc;
  // final DocumentReference<Map<String, dynamic>> gameDoc = FirebaseFirestore.instance.collection('ludo').doc('1');
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _pawnSubscription;

  @override
  void initState() {
    super.initState();
    gameDoc = FirebaseFirestore.instance.collection('ludo').doc("1");
    _fetchPawnAsset(); // Fetch the pawn asset on initialization
    _listenForPawnChanges(); // Listen for pawn position updates
  }

  @override
  void dispose() {
    // Cancel the Firestore listener when the widget is disposed
    _pawnSubscription.cancel();
    super.dispose();
  }

  // Function to fetch pawn asset from Firestore
  Future<void> _fetchPawnAsset() async {
    final snapshot = await gameDoc.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (mounted) {
        setState(() {
          switch (widget.type) {
            case LudoPlayerType.blue:
              pawnAsset = data?['bluePawn'] ?? Assets.diceBluePawn;
              break;
            case LudoPlayerType.red:
              pawnAsset = data?['redPawn'] ?? Assets.diceRedPawn;
              break;
            case LudoPlayerType.green:
              pawnAsset = data?['greenPawn'] ?? Assets.diceGreenpawn;
              break;
            case LudoPlayerType.yellow:
              pawnAsset = data?['yellowPawn'] ?? Assets.diceYellowPawn;
              break;
          }
        });
      }
    }
  }

  // Function to send pawn movement data to Firestore
  Future<void> _sendPawnMovement(int nextStep) async {
    await gameDoc.update({
      '${widget.type.toString().split('.').last}PawnPosition${widget.index}': nextStep,
    });
  }

  // Listen for pawn position changes
  void _listenForPawnChanges() {
    _pawnSubscription = gameDoc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (mounted) {
          setState(() {
            widget.step = data?['${widget.type.toString().split('.').last}PawnPosition${widget.index}'] ?? widget.step;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (widget.type) {
      case LudoPlayerType.blue:
        color = LudoColor.blue;
        pawnAsset = Assets.diceBluePawn;
        break;
      case LudoPlayerType.red:
        color = LudoColor.red;
        pawnAsset = Assets.diceRedPawn;
        break;
      case LudoPlayerType.green:
        color = LudoColor.green;
        pawnAsset =Assets.diceGreenpawn;
        break;
      case LudoPlayerType.yellow:
        color = LudoColor.yellow;
        pawnAsset = Assets.diceYellowPawn;
        break;
      default:
        color = Colors.white;
        pawnAsset = Assets.diceYellowPawn;
    }

    return IgnorePointer(
      ignoring: !widget.highlight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.highlight)
            const RippleAnimation(
              color: Colors.white,
              minRadius: 20,
              repeat: true,
              ripplesCount: 3,
              child: SizedBox.shrink(),
            ),
          Consumer<LudoProvider>(
            builder: (context, provider, child) => GestureDetector(
              onTap: () async {
                // if (step == -1) {
                //   provider.move(type, index, (step + 1) + 1);
                // } else {
                //   provider.move(type, index, (step + 1) + provider.diceResult);
                // }
                // context.read<LudoProvider>().move(type, index, step);
                if (provider.diceResult > 0) {
                  print("hello");
                  int nextStep = widget.step == -1 ? 1 : widget.step + provider.diceResult;

                  // Send move to provider
                  provider.move(context,widget.type, widget.index, nextStep);

                  // Send the pawn movement to Firestore
                  await _sendPawnMovement(nextStep);
                }
              },
              child: Stack(
                children: [
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Transform.scale(
                      scale: 2.5,
                      child: Image.asset(pawnAsset),
                    ),
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

/// latest working
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
//
// import '../../res/app_colors.dart';
// import 'ludo_constant.dart';
// import 'ludo_provider.dart';
//
// class PawnWidget extends StatefulWidget {
//   final int index;
//   final LudoPlayerType type;
//   int step;
//   final bool highlight;
//   final int? initialStep;
//
//   PawnWidget(this.index, this.type, {Key? key, this.highlight = false, this.step = 0, this.initialStep}) : super(key: key);
//
//   @override
//   State<PawnWidget> createState() => _PawnWidgetState();
// }
//
// class _PawnWidgetState extends State<PawnWidget> {
//   late String pawnAsset;
//   final DocumentReference<Map<String, dynamic>> gameDoc = FirebaseFirestore.instance.collection('ludo').doc('1');
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPawnAsset(); // Fetch the pawn asset on initialization
//     _listenForPawnChanges(); // Listen for pawn position updates
//   }
//
//   // Function to fetch pawn asset from Firestore
//   Future<void> _fetchPawnAsset() async {
//     final snapshot = await gameDoc.get();
//     if (snapshot.exists) {
//       final data = snapshot.data();
//       setState(() {
//         switch (widget.type) {
//           case LudoPlayerType.blue:
//             pawnAsset = data?['bluePawn'] ?? "Assets.diceBluePawn";
//             break;
//           case LudoPlayerType.red:
//             pawnAsset = data?['redPawn'] ?? Assets.diceRedPawn;
//             break;
//           case LudoPlayerType.green:
//             pawnAsset = data?['greenPawn'] ?? "Assets.diceGreenPawn";
//             break;
//           case LudoPlayerType.yellow:
//             pawnAsset = data?['yellowPawn'] ?? Assets.diceYellowPawn;
//             break;
//         }
//       });
//     }
//   }
//
//   // Function to send pawn movement data to Firestore
//   Future<void> _sendPawnMovement(int nextStep) async {
//     await gameDoc.update({
//       '${widget.type.toString().split('.').last}PawnPosition${widget.index}': nextStep,
//     });
//   }
//
//   // Listen for pawn position changes
//   void _listenForPawnChanges() {
//     gameDoc.snapshots().listen((snapshot) {
//       if (snapshot.exists) {
//         final data = snapshot.data();
//         setState(() {
//           widget.step = data?['${widget.type.toString().split('.').last}PawnPosition${widget.index}'] ?? widget.step;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color color;
//
//     switch (widget.type) {
//       case LudoPlayerType.blue:
//         color = LudoColor.blue;
//         pawnAsset = "Assets.diceBluePawn";
//         break;
//       case LudoPlayerType.red:
//         color = LudoColor.red;
//         pawnAsset = Assets.diceRedPawn;
//         break;
//       case LudoPlayerType.green:
//         color = LudoColor.green;
//         pawnAsset = "Assets.diceGreenPawn";
//         break;
//       case LudoPlayerType.yellow:
//         color = LudoColor.yellow;
//         pawnAsset = Assets.diceYellowPawn;
//         break;
//       default:
//         color = Colors.white;
//         pawnAsset = Assets.diceYellowPawn;
//     }
//
//     return IgnorePointer(
//       ignoring: !widget.highlight,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (widget.highlight)
//             const RippleAnimation(
//               color: Colors.white,
//               minRadius: 20,
//               repeat: true,
//               ripplesCount: 3,
//               child: SizedBox.shrink(),
//             ),
//           Consumer<LudoProvider>(
//             builder: (context, provider, child) => GestureDetector(
//               onTap: () async {
//                 if (provider.diceResult > 0) {
//                   int nextStep = widget.step == -1 ? 1 : widget.step + provider.diceResult;
//
//                   // Send move to provider
//                   provider.move(widget.type, widget.index, nextStep);
//
//                   // Send the pawn movement to Firestore
//                   await _sendPawnMovement(nextStep);
//                 }
//               },
//               child: Stack(
//                 children: [
//                   SizedBox(height: height * 0.01),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Transform.scale(
//                       scale: 2.5,
//                       child: Image.asset(pawnAsset),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
/// previous
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
//
// import '../../res/app_colors.dart';
// import 'ludo_constant.dart';
// import 'ludo_provider.dart';
//
// class PawnWidget extends StatefulWidget {
//   final int index;
//   final LudoPlayerType type;
//   int step;
//   final bool highlight;
//   final int? initialStep;
//   PawnWidget(this.index, this.type, {Key? key, this.highlight = false, this.step = -0, this.initialStep}) : super(key: key);
//
//   @override
//   State<PawnWidget> createState() => _PawnWidgetState();
// }
//
// class _PawnWidgetState extends State<PawnWidget> {
//   // const PawnWidget(this.index, this.type, {super.key, this.highlight = false, this.step = -1, this.initialStep});
//   int get stepsMoved => (widget.step >= 0 && widget.initialStep != null) ? (widget.step - widget.initialStep!) : 0;
//
//   @override
//   Widget build(BuildContext context) {
//     Color color;
//     final DocumentReference<Map<String, dynamic>> gameDoc = FirebaseFirestore.instance.collection('ludo').doc('1');
//     String pawnAsset;
//
//     switch (widget.type) {
//       case LudoPlayerType.blue:
//         color = LudoColor.blue;
//         pawnAsset = "Assets.diceBluepawn";
//         break;
//       case LudoPlayerType.red:
//         color = LudoColor.red;
//         pawnAsset = Assets.diceRedPawn;
//         break;
//       case LudoPlayerType.green:
//         color = LudoColor.green;
//         pawnAsset = "Assets.diceGreenpawn";
//         break;
//       case LudoPlayerType.yellow:
//         color = LudoColor.yellow;
//         pawnAsset = Assets.diceYellowPawn;
//         break;
//       default:
//         color = Colors.white;
//         pawnAsset = Assets.diceYellowPawn;
//     }
//     gameDoc.update({
//       'redPawn': Assets.diceRedPawn,
//       'yellowPawn': Assets.diceRedPawn,
//     });
//     return IgnorePointer(
//       ignoring: !widget.highlight,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (widget.highlight)
//             const RippleAnimation(
//               color: Colors.white,
//               minRadius: 20,
//               repeat: true,
//               ripplesCount: 3,
//               child: SizedBox.shrink(),
//             ),
//           Consumer<LudoProvider>(
//             builder: (context, provider, child) => GestureDetector(
//               onTap: () {
//                 if (provider.diceResult > 0) {
//                   int nextStep = widget.step == -1 ? 1 : widget.step + provider.diceResult;
//
//                   provider.move(widget.type, widget.index, nextStep); // Send move to provider
//                 }
//               },
//               child: Stack(
//                 children: [
//                   SizedBox(height: height * 0.01),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Transform.scale(
//                       scale: 2.5,
//                       child: Image.asset(pawnAsset),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
//
// import '../../res/app_colors.dart';
// import 'ludo_constant.dart';
// import 'ludo_provider.dart';
//
// ///Widget for the pawn
// class PawnWidget extends StatelessWidget {
//   final int index;
//   final LudoPlayerType type;
//   final int step;
//   final bool highlight;
//   final int ?initialStep;
//
//   const PawnWidget(this.index, this.type, {Key? key, this.highlight = false, this.step = -0,this.initialStep}) : super(key: key);
//   int get stepsMoved => (step != -0 && initialStep != null) ? (step - initialStep!) : 0;

//   @override
//   Widget build(BuildContext context) {
//
//
//     Color color = Colors.white;
//     switch (type) {
//       case LudoPlayerType.blue:
//         color = LudoColor.blue;
//         break;
//       case LudoPlayerType.red:
//         color = LudoColor.red;
//         break;
//       case LudoPlayerType.green:
//         color = LudoColor.green;
//         break;
//       case LudoPlayerType.yellow:
//         color = LudoColor.yellow;
//         break;
//
//
//     }
//
//     String pown = Assets.diceYellowPawn;
//     switch (type) {
//       case LudoPlayerType.blue:
//         pown = "Assets.diceBluepawn";
//         break;
//       case LudoPlayerType.red:
//         pown = Assets.diceRedPawn;
//         break;
//       case LudoPlayerType.green:
//         pown = "Assets.diceGreenpawn";
//         break;
//       case LudoPlayerType.yellow:
//         pown = Assets.diceYellowPawn;
//         break;
//
//
//     }
//
//     return IgnorePointer(
//       ignoring: !highlight,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           if (highlight)
//             const RippleAnimation(
//               color: white,
//               minRadius: 20,
//               repeat: true,
//               ripplesCount: 3,
//               child: SizedBox.shrink(),
//             ),
//           Consumer<LudoProvider>(
//             builder: (context, provider, child) => GestureDetector(
//               onTap: () {
//                 if (step == -1) {
//                   provider.move(type, index, (step + 1) + 1);
//                 } else {
//                   provider.move(type, index, (step + 1) + provider.diceResult);
//                 }
//                 context.read<LudoProvider>().move(type, index, step);
//               },
//               child: Stack(
//                   children: [
//                     SizedBox(height: height*0.01,),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 5.0),
//                       child: Transform.scale(
//                         scale: 2.5,
//                         child: Image.asset(pown),
//                       ),
//                     ),
//                   ]
//               ),
//
//             ),
//           ),
//         ],
//
//       ),
//
//     );
//   }
// }
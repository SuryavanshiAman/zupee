
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/view_model/firebase_view_model.dart';

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
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _pawnSubscription;

  @override
  void initState() {
    super.initState();
    final firebaseViewModel =Provider.of<FirebaseViewModel>(context,listen: false);
    // print("PawnWidget${firebaseViewModel.table}");
    gameDoc = FirebaseFirestore.instance.collection('ludo').doc(firebaseViewModel.table.toString());
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
    final ludoProvider = Provider.of<LudoProvider>(context);
    if (ludoProvider.playerQuantity == 2 && (widget.type != LudoPlayerType.blue && widget.type != LudoPlayerType.green)) {
      return const SizedBox.shrink();
    }
    switch (widget.type) {
      case LudoPlayerType.blue:
        LudoColor.blue;
        pawnAsset = Assets.diceBluePawn;
        break;
      case LudoPlayerType.red:
        LudoColor.red;
        pawnAsset = Assets.diceRedPawn;
        break;
      case LudoPlayerType.green:
         LudoColor.green;
        pawnAsset =Assets.diceGreenpawn;
        break;
      case LudoPlayerType.yellow:
       LudoColor.yellow;
        pawnAsset = Assets.diceYellowPawn;
        break;
      default:
         Colors.white;
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
                if (provider.diceResult > 0) {
                  int nextStep = widget.step == -1 ? 1 : widget.step + provider.diceResult;
                  provider.move(context,widget.type, widget.index, nextStep);
                }
              },
              child: Stack(
                children: [
                  // SizedBox(height: height * 0.012),
                  Padding(
                    padding:  EdgeInsets.only(left: width*0.01),
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


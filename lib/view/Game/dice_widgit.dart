// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';
// import 'package:zupee/generated/assets.dart';
// import 'package:zupee/main.dart';
//
// import 'ludo_constant.dart';
// import 'ludo_provider.dart';
//
// /// Widget for the dice
// class DiceWidget extends StatefulWidget {
//   const DiceWidget({super.key});
//
//   @override
//   State<DiceWidget> createState() => _DiceWidgetState();
// }
//
// class _DiceWidgetState extends State<DiceWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     return StreamBuilder(
//       stream: _firestore.collection('ludo').doc('1').snapshots(),
//       builder: ( context,snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong: ${snapshot.error}'));
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return const Center(child: Text('No data available'));
//         }
//
//         String cardImage = snapshot.data!['cardImage'] ?? '';
//
//         return   Consumer<LudoProvider>(
//           builder: (context, value, child) =>
//               RippleAnimation(
//                 color: value.gameState == LudoGameState.throwDice ? value
//                     .currentPlayer.color : Colors.white.withOpacity(0),
//                 ripplesCount: 3,
//                 minRadius: 30,
//                 repeat: true,
//                 child: InkWell(
//                   onTap: () async{
//                     value.throwDice();
//                     value.setLoading(true);
//                     setState(() {
//                        _firestore.collection('ludo').doc('1').update({
//
//                         'cardImage':'assets/dice/${value.diceResult}.webp',
//                       });
//                     });
//
//                   },
//                   child: Container(
//                       alignment: Alignment.center,
//                       height: height * 0.08,
//                       width: width * 0.19,
//                       decoration:  const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(Assets.ludoDiceSectionOne),
//                               fit: BoxFit.fill)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child:value.diceStarted? Image(
//                           image: const AssetImage(
//                             "assets/dice/dice.gif",
//                           ),
//                           height: height * 0.06,
//                           width: width * 0.17,
//                         ): Image(
//                           image: cardImage.startsWith('http')
//                               ? NetworkImage(cardImage)
//                               : AssetImage("assets/dice/${value.diceResult}.webp") as ImageProvider,
//                           height: height * 0.06,
//                           width: width * 0.17,
//                         ),
//                       )),
//                 ),
//               ),
//         );
//       },
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../generated/assets.dart';
import 'ludo_provider.dart';
import 'ludo_constant.dart';

class DiceWidget extends StatelessWidget {
  const DiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ludoProvider = context.watch<LudoProvider>();

    return RippleAnimation(
      color: ludoProvider.gameState == LudoGameState.throwDice
          ? ludoProvider.currentPlayer.color
          : Colors.white.withOpacity(0),
      ripplesCount: 3,
      minRadius: 30,
      repeat: true,
      child: InkWell(
        onTap: () {
          if (!ludoProvider.diceStarted&&!ludoProvider.stopDice ) {
            ludoProvider.throwDice(context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.19,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.ludoDiceSectionOne),
              fit: BoxFit.fill,
            ),
          ),
          child: ludoProvider.diceStarted
              ? Image.asset(
            "assets/dice/dice.gif",
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.17,
          )
              : Image.asset(
            "assets/dice/${ludoProvider.diceResult}.webp",
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.17,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/time_page.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view/home/popup.dart';

class TournamentBottomsheet extends StatefulWidget {
final String ?futureTime;
  const TournamentBottomsheet({super.key,required this.futureTime});

  @override
  State<TournamentBottomsheet> createState() => _TournamentBottomsheetState();
}

class _TournamentBottomsheetState extends State<TournamentBottomsheet> {
  Future<Future> onWillPop() async {

    return   showDialog(
      context: context,
      builder: (BuildContext context) {
        return const BackPopup();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final ludoProvider = Provider.of<LudoProvider>(context);
    return PopScope(
      canPop:ludoProvider.status==true? false:true,
      onPopInvoked: (v) {
        ludoProvider.status==true?
        onWillPop():null;
      },
      child: SizedBox(
        height: height * 0.4,
        width: width,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 28.0, top: 28),
              child: InkWell(
                  onTap: () {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const BackPopup();
                      },
                    );

                    // Navigator.pop(context);
                  },
                  child: const Icon(Icons.close)),
            ),
            SizedBox(height: height / 30),
            Center(
                child: Image.asset(
                  Assets.gifIcons8Hourglass,
                )),
            SizedBox(height: height * 0.03),
            Center(
                child: Text(
                  "Game Start in.....".tr,
                  style: const TextStyle(
                      fontSize: 24,
                      color: green,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(height: height * 0.03),
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  decoration: const BoxDecoration(
                    color: green,
                    borderRadius:
                    BorderRadius.all(Radius.circular(35)),
                  ),
                  child:  CountdownTimer(
                    futureTime: widget.futureTime,
                    onTimerTick: (int value) {
                    }, fontWeight: FontWeight.w600, fontSize: 24, color: white,
                  ),

                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}

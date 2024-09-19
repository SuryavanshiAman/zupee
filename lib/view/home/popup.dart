
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/send_result_view_model.dart';


class BackPopup extends StatefulWidget {
  const BackPopup({super.key});

  @override
  State<BackPopup> createState() => _BackPopupState();
}

class _BackPopupState extends State<BackPopup> {

  @override
  Widget build(BuildContext context) {
    final ludoProvider=Provider.of<LudoProvider>(context,listen: false);
    return Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            // alignment: Alignment.center,
            height: height * 0.2,
            width: width * 0.8,
            decoration: const BoxDecoration(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(15)),
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height*0.08,
                  padding: EdgeInsets.only(left: width*0.04),
                  // alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight:
                    Radius.circular(15),
                        topLeft:  Radius.circular(15)
                    ),
                    color: tertiary,
                  ),
                  child:  const Center(
                    child: Text(
                      'Your amount id debited are you really want to go back?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.055,),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceAround,
                  children: [
                    InkWell(
                      onTap: ()  {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          final sendResultViewModel=Provider.of<SendResultViewModel>(context,listen: false);
                          final ludoProvider=Provider.of<LudoProvider>(context,listen: false);
                          sendResultViewModel.sendResultApi(ludoProvider.tournamentId.toString(), "4", "0", context);
                        });
                        ludoProvider.removePlayerName(context);
                        Navigator.pushNamed(context, RoutesName.bottomNevBar ,arguments: {"index": 0});
                      },
                      child: Container(
                        alignment: Alignment
                            .center,
                        height:
                        height * 0.05,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                           color: secondary,
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(
                            //     color: Colors.red.shade900, width: 3)
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment
                            .center,
                        height:
                        height * 0.05,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: labelColor,
                          borderRadius: BorderRadius.circular(25),),
                        // border: Border.all(
                        //     color: Colors.red.shade900, width: 3)),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                            color: Colors
                                .white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

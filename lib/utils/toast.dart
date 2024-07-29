// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

import '../res/app_colors.dart';

class Utils {
  static void showErrorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 20,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: red,
        textColor: Colors.white);
  }

  static void showSuccessToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white70);
  }

  static void flushBarErrorMessage(
      String message, BuildContext context, Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        messageColor: messageColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: red,
        borderRadius: BorderRadius.circular(20),
        positionOffset: 20,
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(
      String message, BuildContext context, Color messageColor) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        messageColor: messageColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: BorderRadius.circular(20),
        positionOffset: 20,
        icon: const Icon(
          Icons.check_circle_outline_outlined,
          size: 30,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static showExitConfirmation(BuildContext context) async {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return await showModalBottomSheet(
          elevation: 5,
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          context: context,
          builder: (context) {
            return Container(
              height: height * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0, top: 28),
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close)),
                  ),
                  SizedBox(height: height / 30),
                  Center(
                    child: Text("Exit App",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: height*0.02),
                  Center(
                    child: Text("Are you sure want to exit app?",
                        style: TextStyle(
                          color: labelColor,
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(height: height * 0.04),
                  Center(
                    child: Container(
                      width: width * 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  // side:
                                      // BorderSide(width: 1, color: Colors.white),
                                  // elevation: 3,
                                  backgroundColor: secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.34,
                                      vertical: height * 0.02)),
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: Text("Yes",
                                  style: TextStyle(
                                      color: tertiary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(height: height * 0.03),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(width: 1,color: tertiary),
                                  // elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.34,
                                      vertical: height * 0.02)),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      color: tertiary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ) ??
        false;
  }
}

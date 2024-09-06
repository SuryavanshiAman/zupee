import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageToast {
  static void show({
    required String imagePath,
    required String text,
    required BuildContext context,
    double? width,
    double? height,
  }) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Opacity(
        opacity: 0.9,
        child: Container(
          alignment: Alignment.center,
          width: width ?? MediaQuery.of(context).size.width,
          height:height?? MediaQuery.of(context).size.height * 3.18,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(imagePath),
            ),
          ),
          child: Text(text,style: TextStyle(fontWeight: FontWeight.w600,),),
        ),
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 3),
    );
  }
}

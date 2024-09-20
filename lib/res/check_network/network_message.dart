import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_container.dart';

class NetworkErrorScreen extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const NetworkErrorScreen({Key? key, this.onRetry,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: const AssetImage(Assets.imagesNoInternet,),height: height*0.12,),
              const SizedBox(height: 20),
              const Text(
                "Unable to connect with our servers. Please check your internet connection.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: labelColor,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: CustomContainer(
                  onTap: () async {

                  },
                  alignment: Alignment.center,
                  height: height * 0.06,
                  widths: width * 0.4,
                  color: secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child: Text(
                    "Try Again".tr,
                    style: const TextStyle(
                        fontSize: 16,
                        color: tertiary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/app_constant.dart';


class HtmlViewerScreen extends StatefulWidget {
  const HtmlViewerScreen({super.key});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {

  late String htmlContent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as String;
    htmlContent = args;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: secondary,
            leading:Image.asset(Assets.imagesZupee),
            title: const Text(AppConstants.appNameTwo, style: TextStyle(
                color: tertiary, fontSize: 26, fontWeight: FontWeight.w900),),
            actions: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.cancel,color: tertiary,))
            ],
          ),
          body:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: HtmlWidget(htmlContent),
              )),
        )
    );
  }
}

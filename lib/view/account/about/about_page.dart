import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/helper/response/status.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/view_model/about_view_model.dart';

import '../../../res/custom_back_button.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  AboutViewModel aboutViewModel = AboutViewModel();
  @override
  void initState() {
    aboutViewModel.aboutApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 200,
        leading: Row(
          children: [
            CustomBackButton(),
            Text(
              "About".tr,
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Select a topic to find help",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
            // SizedBox(height: height*0.03,),
            Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ChangeNotifierProvider<AboutViewModel>(
                  create: (BuildContext context) => aboutViewModel,
                  child: Consumer<AboutViewModel>(
                    builder: (context, resultValue, _) {
                      switch (resultValue.aboutList.status) {
                        case Status.LOADING:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.ERROR:
                          return Container();
                        case Status.COMPLETED:
                          final aboutData = resultValue.aboutList.data!.data;
                          if (aboutData != null && aboutData.isNotEmpty) {
                            return ListView.builder(
                              itemCount: aboutData.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RoutesName.htmlViewerScreen,
                                            arguments: aboutData[index].about![0].description!,);
                                        },
                                        child: HelpRow(
                                          label:
                                              aboutData[index].name.toString(),
                                        )),
                                    Divider(
                                      height: height * 0.06,
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "No Deposit History Found!",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            );
                          }
                        default:
                          return Container();
                      }
                    },
                  ),
                )
                // Column(
                //
                //   children: [
                //     HelpRow(label:"Responsible gaming" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"Fairplay" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"RNG Certificates" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"Privacy Policy" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"Terms & Condition" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"About" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"Login Issue" ,),
                //     Divider(height: height*0.06,),
                //     HelpRow(label:"Other Issues" ,),
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

class HelpRow extends StatelessWidget {
  final String label;

  const HelpRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: black, fontWeight: FontWeight.w500, fontSize: 16)),
        Icon(
          Icons.arrow_forward_ios_sharp,
          size: 20,
        )
        // Text(value, style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 18)),
      ],
    );
  }
}

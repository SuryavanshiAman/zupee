import 'package:flutter/material.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/utils/routes_name.dart';

import '../../generated/assets.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  String number = '7485499624';

  String maskNumber(number) {
    if (number.length < 2) return number; // If the number is too short, return as is
    String firstPart = number.substring(0, 2); // First two digits
    String lastPart = number.substring(number.length - 2); // Last two digits
    String maskedPart = 'x' * (number.length - 4); // Middle part replaced with 'x'
    return '$firstPart$maskedPart$lastPart';
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Color(0xff1e2283)
            // image: DecorationImage(
            //     image: AssetImage(Assets.ludoWinnerBg), fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.03,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                    height: height*0.5,
                    width: width*0.6,
                    child: Image.asset(Assets.imagesStx,fit: BoxFit.fill,),),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height*0.1),
                      height: height * 0.37,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: lightBlueTwo, borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height*0.07,),
                          Container(
                              alignment: Alignment.center,
                              height: height * 0.04,
                              width: width * 0.18,
                              decoration: BoxDecoration(
                                  color: black.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                              child: const Text("WINNER",style: TextStyle(color: cream,fontWeight: FontWeight.w500),)),
                          SizedBox(height: height*0.01,),
                          const Text("You have won ₹1.7",style: TextStyle(color: white,fontWeight: FontWeight.w500,fontSize:18 ),),
                          SizedBox(height: height*0.025,),
                          Row(
                            children: [
                              Spacer(),
                              const Text("Score",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:13 ),),
                              SizedBox(width: width*0.1,),
                              const Text("Prize",style: TextStyle(color: cream,fontWeight: FontWeight.w600,fontSize:13 ),),
                              SizedBox(width: width*0.08,),
                            ],
                          ),
                          SizedBox(height: height*0.005,),
                          Container(
                            padding: EdgeInsets.all(3),
                            height: height*0.055,
                            width: width*0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: white,width: 1),
                                color: blue, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [

                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0,top: 9),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: width*0.12,
                                          height: height*0.025,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                              image: DecorationImage(image: AssetImage(Assets.imagesFirsrt),fit: BoxFit.fill)
                                          ),
                                          child: Text("1st",style: TextStyle(color: cream,fontWeight: FontWeight.w600,fontSize:13 ))
                                      ),
                                    ),
                                    Container(

                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: AssetImage(Assets.ludoProfileSection))
                                        ),
                                        child: Image.asset(Assets.ludoUser,)),
                                  ],
                                ),
                                SizedBox(width: width*0.03,),
                                Text("+91${maskNumber(number)}",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:13 )),
                                SizedBox(width: width*0.04,),
                                Text("273",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),
                                SizedBox(width: width*0.1,),
                                Text("₹1.7",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),


                              ],
                            ),

                          ),
                          SizedBox(height: height*0.01,),

                          Container(
                            padding: EdgeInsets.all(3),
                            height: height*0.055,
                            width: width*0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: white,width: 1),
                                color: Color(0xff1e2283).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [

                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0,top: 9),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: width*0.12,
                                          height: height*0.025,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                              image: DecorationImage(image: AssetImage(Assets.imagesFirsrt),fit: BoxFit.fill)
                                          ),
                                          child: Text("2nd",style: TextStyle(color: cream,fontWeight: FontWeight.w600,fontSize:13 ))
                                      ),
                                    ),
                                    Container(

                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: AssetImage(Assets.ludoProfileSection))
                                        ),
                                        child: Image.asset(Assets.ludoUser,)),
                                  ],
                                ),
                                SizedBox(width: width*0.03,),
                                Text("+91${maskNumber(number)}",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:13 )),
                                SizedBox(width: width*0.04,),
                                Text("273",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),
                                SizedBox(width: width*0.1,),
                                Text("₹1.7",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),


                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top:height* 0.03),
                      child: Image.asset(Assets.ludoCrown),
                    ),


                  ],
                )

              ],
            ),
            //
        Text("Share your success!",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:16 )),
            SizedBox(height: height*0.01,),
        Container(
          padding: EdgeInsets.all(4),
          // margin: EdgeInsets.only(top: height*0.1),
          height: height * 0.055,
          width: width * 0.4,
          decoration: BoxDecoration(
              color: black.withOpacity(0.4), borderRadius: BorderRadius.circular(55)),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(Assets.imagesWhatsapp),
            Image.asset(Assets.iconFacebok),
            Image.asset(Assets.imagesShare),
          ],
        )
        ),
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar ,arguments: {"index": 0});
              },
              child: Container(
                alignment: Alignment.center,
                height: height*0.07,
                width: width*0.8,
                decoration: const BoxDecoration(
                    color: Color(0xff1e2283),
                  image: DecorationImage(
                      image: AssetImage(Assets.ludoLobby), fit: BoxFit.fill)
                ),
                child: Text("GO TO LOBBY",style: TextStyle(color: white,fontWeight: FontWeight.w600,fontSize:22 )),
              ),
            ),
            SizedBox(height: height*0.15,),
          ],
        ),
      ),
    );
  }
}

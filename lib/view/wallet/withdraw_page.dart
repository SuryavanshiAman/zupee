import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_container.dart';

import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/profile_view_model.dart';
import 'package:zupee/view_model/withdraw_view_model.dart';

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width * 0.08, size.height);
    path.lineTo(size.width * 0.92, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _controller = TextEditingController();
  // int _currentAmount = 0;
  // void _updateAmount(int amount) {
  //   setState(() {
  //     _currentAmount += amount;
  //     _controller.text = _currentAmount.toString();
  //   });
  // }

  Color _containerColor = lightGray;
  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateContainerColor);
  }

  void _updateContainerColor() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _containerColor = secondary;
      } else {
        _containerColor = lightGray;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final withdrawViewModel = Provider.of<WithdrawViewModel>(context);
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).profileResponse?.data;
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Withdraw Money",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        height: height * 0.2,
                        width: width * 0.9,
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),

                            // const Text("Enter Amount",style: TextStyle(fontSize: 16),),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            CustomTextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              label: "Enter amount here",
                              hintColor: labelColor,
                              height: 70,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              // borderRadius: ,
                              filled: true,
                              borderSide: const BorderSide(color: blue),
                              borderSideFocus: const BorderSide(color: blue),
                              fillColor: tertiary.withOpacity(0.2),
                              fieldRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              prefix: const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "₹",
                                  style: TextStyle(color: black, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, bottom: 10),
                      child: ClipPath(
                        clipper: TrapeziumClipper(),
                        child: Container(
                          width: width * 0.6,
                          height: height * 0.03,
                          margin: const EdgeInsets.all(5),
                          color: tertiary.withOpacity(0.2),
                          child: const Center(
                            child: Text(
                              'Available for withdrawal ₹0 ',
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(top: 10),
                height: height * 0.2,
                width: width * 0.9,
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: labelColor,
                      // child: Icon(Icons.),
                    ),
                    Text(
                      "Withdraw",
                      style: TextStyle(
                          color: labelColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Min-₹1,Max-₹20,000",
                      style: TextStyle(
                          color: red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),

       if (double.parse( profileViewModel!.wallet.toString()) >=300) Container(
            alignment: Alignment.center,
            height: height*0.1,
            width: width,

            decoration: BoxDecoration(
              color: appBarColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, -1), // changes position of shadow to the top
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                  onTap: (){
                    if (_controller.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please Enter the Amount".tr, context,white);
                    } else if (int.parse(_controller.text) < 100) {
                      Utils.flushBarErrorMessage(
                          "Please Enter the Amount at least ₹100".tr,
                          context,white);
                    } else {
                      withdrawViewModel.withdrawApi(_controller.text, context);
                    }
                  },
                  alignment: Alignment.center,
                  height: height*0.07,
                  widths: width*0.8,
                  color: _containerColor,
                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                  child:  Text("Withdraw Money".tr,style: const TextStyle(color: labelColor,fontWeight: FontWeight.w500),),
                ),
                Text("100% Secure Payments".tr,style: const TextStyle(color: green),)
              ],
            ),
          ) else Container()
        ],
      ),
    );
  }
}

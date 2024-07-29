
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/custom_back_button.dart';
import '../../../res/app_colors.dart';



class LossManagementScreen extends StatefulWidget {
  const LossManagementScreen({super.key});

  @override
  _LossManagementScreenState createState() => _LossManagementScreenState();
}

class _LossManagementScreenState extends State<LossManagementScreen> {
  double _lossAmount = 2000;
  String _selectedTimePeriod = '1 Day';
  String _selectedGameLockPeriod = '1 Day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 220,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Loss Management",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height*0.24,
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
              child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What is Loss Management?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height*0.02,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width*0.52,
                    child: RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan( text: "Loss Management is a tool to help you play responsibly by limiting the amount of loss you can incur in a period of time.".tr,
                        style: const TextStyle(fontSize: 16, color: black),
                        children: [
                          TextSpan(
                            text: 'Read More'.tr,
                            style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _showLossManagementBottomSheet(context);
                              },
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(width: 16),

                  CircleAvatar(
                      radius: 40,
                      backgroundColor: lightBlue,
                      child: Image(image: const AssetImage(Assets.imagesDownword),height: height*0.07,)
                  ),

                ],
              ),


            ],
          ),
                ),
              ),
              SizedBox(height: height*0.03,),
              Container(
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        'Initiate Loss Management',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: lightBlue,
                                child: Text("₹"),
                              ),
                              // const Icon(Icons.money, color: Colors.purple),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 1,
                                  height: height*0.162,
                                  color: lightBlue,
                                ),
                              ),
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: lightBlue,
                                child:Icon(Icons.timer, color:blue),
                              ),
                              // const Icon(Icons.timer, color: Colors.purple),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 1,
                                  height: height*0.162,
                                  color: lightBlue,
                                ),
                              ),
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: lightBlue,
                                child:Icon(Icons.lock, color:blue),
                              ),
                              // const Icon(Icons.lock, color: Colors.purple),
                            ],
                          ),
                          SizedBox(width: width*0.03,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              _buildLossAmountLimitSection(),
                              const SizedBox(height: 20),
                              _buildTimePeriodSection(),
                              const SizedBox(height: 20),
                              _buildGameLockPeriodSection(),
                              const SizedBox(height: 20),
                            ],
                          )
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.yellow[700], // text color
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          ),
                          onPressed: () {
                            // Handle confirm button press
                          },
                          child: const Text(
                            'Confirm my choice',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLossAmountLimitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set Loss Amount Limit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Access to all games will be restricted\n when you incur this loss amount',
          style: TextStyle(fontSize: 14, color: labelColor),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width*0.6,
          child: Slider(
            activeColor: blue,
            value: _lossAmount,
            min: 2000,
            max: 100000,
            divisions: 100,
            label: '₹${_lossAmount.toStringAsFixed(0)}',
            onChanged: (value) {
              setState(() {
                _lossAmount = value;
              });
            },
          ),
        ),
        const Text(
          'Min - ₹2,000 and Max - ₹100,000',
          style: TextStyle(fontSize: 14, color: labelColor),
        ),
      ],
    );
  }

  Widget _buildTimePeriodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set Time Period',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Loss amount is calculated for this\n period',
          style: TextStyle(fontSize: 14, color: labelColor),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildPeriodButton('1 Day', _selectedTimePeriod, (value) {
              setState(() {
                _selectedTimePeriod = value;
              });
            }),
            _buildPeriodButton('3 Days', _selectedTimePeriod, (value) {
              setState(() {
                _selectedTimePeriod = value;
              });
            }),
            _buildPeriodButton('1 Week', _selectedTimePeriod, (value) {
              setState(() {
                _selectedTimePeriod = value;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildGameLockPeriodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set Game Lock Period',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Access to game will be restricted for\n this period',
          style: TextStyle(fontSize: 14, color: labelColor),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPeriodButton('1 Day', _selectedGameLockPeriod, (value) {
              setState(() {
                _selectedGameLockPeriod = value;
              });
            }),
            _buildPeriodButton('3 Days', _selectedGameLockPeriod, (value) {
              setState(() {
                _selectedGameLockPeriod = value;
              });
            }),
            _buildPeriodButton('1 Week', _selectedGameLockPeriod, (value) {
              setState(() {
                _selectedGameLockPeriod = value;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String text, String selectedPeriod, Function(String) onTap) {
    bool isSelected = text == selectedPeriod;
    return InkWell(
      onTap: () => onTap(text),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          height: height*0.045,
          width: width*0.16,
          decoration: BoxDecoration(
            border: Border.all(color: blue),
            color: isSelected ? blue : white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
  void _showLossManagementBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                      radius: 60,
                      backgroundColor: lightBlue,
                      child: Image(image: const AssetImage(Assets.imagesDownword),height: height*0.07,)
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'What is Loss Management?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'With our Loss Management tools, you can define loss limits for yourself and reaching the limits will automatically restrict your gameplay for a specific period.',
                  style: TextStyle(
                    fontSize: 16,
                    color: labelColor,
                    fontWeight: FontWeight.w400,
                  ),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You can set the following:',
                        style: TextStyle(
                          fontSize: 16,
                            color: labelColor,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height*0.02),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '• Loss Amount Limit\n'),
                            TextSpan(
                              text: '  Min ₹2000 - Max ₹100000',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.02),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '• Time Period\n'),
                            TextSpan(
                              text: '  1 Day, 3 Days or 7 Days',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.02),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '• Game Lock Period\n'),
                            TextSpan(
                              text: '  1 Day, 3 Days or 7 Days',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(child: Icon(Icons.horizontal_rule, size: 30, color: Colors.grey)),
                SizedBox(height: 20),
                Text(
                  'For example:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'If you choose Loss Amount Limit as ₹10,000 and Time Period as 1 Day, once you incur a loss of ₹10,000 in a day, access to all games will be restricted.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.yellow[700], // text color
                      padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

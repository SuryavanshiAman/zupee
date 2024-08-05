import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view_model/add_bank_details_view_model.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

bool _loading = false;

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  TextEditingController accountNo = TextEditingController();
  TextEditingController iFSC = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController uPI = TextEditingController();
  TextEditingController acHolder = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _isValidIFSC = false;

  void validateIFSC(String iFSC) {
    RegExp iFSCRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    setState(() {
      _isValidIFSC = iFSCRegex.hasMatch(iFSC.toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final addBank = Provider.of<AddBankDetailsViewModel>(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 200,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
                size: 30,
              ),
            ),
            Text(
              "Bank Details".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              children: [
                const Text(
                  "Enter Bank Details:-",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: acHolder,
                  label: "Enter A/c holder name".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  // borderRadius: ,
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: accountNo,
                  keyboardType: TextInputType.number,
                  label: "Enter Account NO".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  // maxLength: 10,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  // borderRadius: ,
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Icon(Icons.onetwothree),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: bankName,
                  // keyboardType: TextInputType.number,
                  label: "Enter Bank Name".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  // maxLength: 10,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Icon(Icons.account_balance_outlined),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: branch,
                  // keyboardType: TextInputType.number,
                  label: "Enter branch Name".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  // maxLength: 10,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Icon(Icons.account_balance_outlined),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  controller: iFSC,
                  onChanged: (value) {
                    validateIFSC(value.toUpperCase());
                  },
                  // keyboardType: TextInputType.number,
                  label: "Enter iFSC Code".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  maxLength: 11,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Icon(Icons.password),
                ),
                const SizedBox(
                  height: 20,
                ),
                _loading == false
                    ? InkWell(
                  onTap: (){
                    if (_isValidIFSC) {
                      addBank.addBankDetailsApi(
                          acHolder.text,
                          accountNo.text,
                          bankName.text,
                          branch.text,
                          iFSC.text,
                          context);
                    } else {
                      Utils.flushBarErrorMessage(
                        "Please enter valid ifsc",
                        context,
                        white
                      );
                    }
                  },
                      child: Container(
                          alignment: Alignment.center,
                          height: height * 0.08,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: const Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: tertiary, fontWeight: FontWeight.w600),
                          ),
                        ),
                    )
                    : Container()
              ],
            ),
          )
        ],
      ),
    ));
  }
}

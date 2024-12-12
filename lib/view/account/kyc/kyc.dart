import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/Game/ludo_provider.dart';
import 'package:zupee/view_model/kyc_view_model.dart';
import 'package:zupee/view_model/user_view_model.dart';
import 'package:zupee/view_model/view_kyc_details_view_model.dart';

import '../../../res/custom_back_button.dart';
import '../../bottomsheet/kyc_bottomsheet.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({super.key});

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  @override
  void initState() {

    super.initState();
    Provider.of<ViewKycDetailViewModel>(context, listen: false).viewKycDetailsApi(context);
    kycDetail();
  }

  kycDetail() {
    final kycDetails =
        Provider.of<ViewKycDetailViewModel>(context, listen: false).kycResponse;
    _controller.text =
    kycDetails == null ? '' : kycDetails.data!.legalName.toString();
    _aadhaarController.text =
    kycDetails == null ? '' : kycDetails.data!.aadhaarNo.toString();
    _panController.text =
    kycDetails == null ? '' : kycDetails.data!.pancardNo.toString();
    // ifscCont.text =
    // kycDetails == null ? '' : kycDetails.data!.ifscCode.toString();
  }
  @override
  Widget build(BuildContext context) {
    final kycDetails =
        Provider.of<ViewKycDetailViewModel>(context, listen: false).kycResponse;
    final selectImage = Provider.of<LudoProvider>(context);
    final kyc = Provider.of<AddKycViewModel>(context);

    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: 250,
        leading: const Row(
          children: [
            CustomBackButton(),
            Text(
              "Complete Your KYC",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          const Text(
            'Upload document for  KYC verification',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                  return const TermsAndConditionsBottomSheet();
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              // height: height*0.12,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: black,
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      const Text(
                        'Enter your legal name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextField(
                    controller: _controller,
                    label: "Enter your name".tr,
                    hintColor: labelColor,
                    hintSize: 18,
                    height: 55,
                    width: width * 0.8,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    filled: true,
                    borderSide: const BorderSide(color: tertiary, width: 2),
                    borderSideFocus: const BorderSide(color: blue),
                    fillColor: lightBlue,
                    fieldRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    prefix: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: black,
                      child: Text(
                        '2',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'Aadhaar Details',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                CustomTextField(
                  controller: _aadhaarController,
                  keyboardType: TextInputType.number,
                  label: "Enter your aadhaar number".tr,
                  hintColor: labelColor,
                  height: 55,
                  width: width * 0.8,
                  maxLength: 12,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  // borderRadius: ,
                  filled: true,
                  borderSide: const BorderSide(color: tertiary, width: 2),
                  borderSideFocus: const BorderSide(color: blue),
                  fillColor: lightBlue,
                  fieldRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  prefix: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.numbers,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                const Text(
                  "Upload Aadhaar Images",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width * 0.32,
                      decoration: BoxDecoration(
                          border: selectImage.aadhaarImage == null
                              ? Border.all(color: labelColor)
                              : null,
                          image: DecorationImage(
                              image: selectImage.aadhaarImage != null
                                  ? FileImage(selectImage.aadhaarImage!)
                                  :  NetworkImage(kycDetails?.data?.aadhaarCardImageFront??""),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      height: height * 0.08,
                      width: width * 0.32,
                      decoration: BoxDecoration(
                          border: selectImage.aadhaarBackImage == null
                              ? Border.all(color: labelColor)
                              : null,
                          image: DecorationImage(
                              image: selectImage.aadhaarBackImage != null
                                  ? FileImage(selectImage.aadhaarBackImage!)
                                  :  NetworkImage(kycDetails?.data?.aadhaarCardImageBack??""),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        selectImage.getAadhaarImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: secondary,
                          // border: Border.all(color: lightGray),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Text(
                          "Submit Front  Image",
                          style: TextStyle(color: tertiary),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectImage.getAadhaarBackImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: height * 0.05,
                        // width: width * 0.3,
                        decoration: BoxDecoration(
                          color: secondary,
                          // border: Border.all(color: lightGray),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Text(
                          "Submit Back  Image",
                          style: TextStyle(color: tertiary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            // height: height*0.12,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: black,
                      child: Text(
                        '3',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text(
                      'PAN Details',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomTextField(
                  controller: _panController,
                  label: "Enter your PAN number".tr,
                  hintColor: labelColor,
                  height: 70,
                  width: width * 0.8,
                  maxLength: 10,
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
                  prefix: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.numbers,
                      color: black,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  "Upload PAN Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width * 0.32,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: selectImage.panImage != null
                                  ? FileImage(selectImage.panImage!)
                                  :  NetworkImage(kycDetails?.data?.panCardImage??""),
                              fit: BoxFit.fill),
                          border: selectImage.panImage == null
                              ? Border.all(color: labelColor)
                              : null),
                    ),
                    InkWell(
                      onTap: () {
                        selectImage.getPanImage(ImageSource.gallery);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: secondary,
                          // border: Border.all(color: lightGray),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Text(
                          "Submit PAN Image",
                          style: TextStyle(color: tertiary),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: InkWell(
        onTap: () async{
          if (_controller.text.isEmpty) {
            Utils.flushBarErrorMessage("Please enter Aadhaar name", context,white);
          } else if (_aadhaarController.text.isEmpty || _aadhaarController.text.length <12) {
            Utils.flushBarErrorMessage("Please enter valid Aadhaar no.", context,white);
          }
          else if (_panController.text.isEmpty || _panController.text.length <10) {
            Utils.flushBarErrorMessage("Please enter PAN No.",context,white);
          }else if (selectImage.aadhaarImage == null ) {
            Utils.flushBarErrorMessage("Please  upload Aadhaar front image.",context,white);
          }
          else if (selectImage.aadhaarBackImage == null ) {
            Utils.flushBarErrorMessage("Please upload Aadhaar back image.",context,white);
          }
          else if (selectImage.panImage == null ) {
            Utils.flushBarErrorMessage("Please upload PAN image.",context,white);
          }else {
            UserViewModel userViewModel = UserViewModel();
            String? userId = await userViewModel.getUser();
            Map data = {
              "userid": userId,
              "legal_name": _controller.text,
              "aadhaar_no": _aadhaarController.text,
              "pancard_no": _panController.text,
              "aadhaar_card_image_front": selectImage.aadhaarImage.toString(),
              "aadhaar_card_image_back": selectImage.aadhaarBackImage.toString(),
              "pan_card_image": selectImage.panImage.toString(),
            };
            kyc.addKycApi(data, context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 18),
          height: height * 0.08,
          width: width,
          decoration: const BoxDecoration(
            color: secondary,
          ),
          child: const Text(
            "SUBMIT",
            style: TextStyle(color: tertiary),
          ),
        ),
      ),
    );
  }
}

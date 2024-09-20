import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zupee/generated/assets.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';
import 'package:zupee/res/custom_back_button.dart';
import 'package:zupee/res/custom_text_field.dart';
import 'package:zupee/utils/routes_name.dart';
import 'package:zupee/utils/toast.dart';
import 'package:zupee/view/bottomsheet/edit_profile_bottomsheet.dart';
import 'package:zupee/view_model/profile_view_model.dart';

import '../../view_model/profile_update_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedPrivacyOption = "Everyone";
  IconData _selectedPrivacyIcon = Icons.visibility;

  @override
  void initState() {
    super.initState();
    viewProfile();
  }

  viewProfile() {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false)
            .profileResponse
            ?.data;
    _nameController.text = (profileViewModel?.username.toString() ??
        profileViewModel?.mobileNumber.toString())!;
  }

  File? _image;
  final picker = ImagePicker();
  String? base64Image;
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }

  void _showBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return PrivacyOptionsBottomSheet(
          selectedOption: _selectedPrivacyOption,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedPrivacyOption = result['option'];
        _selectedPrivacyIcon = result['icon'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileUpdate = Provider.of<ProfileUpdateViewModel>(context);
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).profileResponse?.data;
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: primary,
        leadingWidth: 220,
        leading: Row(
          children: [
            const CustomBackButton(),
            Text(
              'Edit Profile'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set Profile Picture".tr,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Center(
                      child: profileViewModel!.profilePicture != null &&
                              _image == null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  profileViewModel.profilePicture.toString()),
                            )
                          : _image == null
                              ? const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage(Assets.iconAccount),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_image!),
                                )),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: tertiary,
                              ),
                              onPressed: () {
                                _getImage(ImageSource.camera);
                              },
                            ),
                          ),
                          Text(
                            'Open \nCamera'.tr,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(Icons.photo_camera_back_outlined,
                                  color: tertiary),
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                              },
                            ),
                          ),
                          Text(
                            'Select from \nGallery'.tr,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            child: IconButton(
                              icon: const Icon(Icons.person_outline,
                                  color: tertiary),
                              onPressed: () {},
                            ),
                          ),
                          const Text(
                            'Select \nAvatar',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set Display Name".tr,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Numbers, special characters are not allowed".tr,
                    style: const TextStyle(fontSize: 14, color: labelColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    contentPadding: const EdgeInsets.all(15),
                    controller: _nameController,
                    height: height * 0.08,
                    filled: true,
                    fillColor: lightBlue,
                    fieldRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy Management".tr,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Control who can see your game history".tr,
                      style: const TextStyle(fontSize: 14, color: labelColor),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        Text(
                          "My Game History".tr,
                          style:
                              const TextStyle(fontSize: 14, color: labelColor),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: height * 0.035,
                            width: width * 0.4,
                            decoration: const BoxDecoration(
                              color: lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_selectedPrivacyIcon,
                                    size: 16, color: black),
                                const SizedBox(width: 4),
                                Text(
                                  _selectedPrivacyOption,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const Spacer(),
                                const Icon(Icons.keyboard_arrow_down,
                                    size: 16, color: tertiary),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                if (_nameController.text.isNotEmpty) {
                  profileUpdate.profileUpdateApi(
                      _nameController.text,
                      base64Image != null ? base64Image.toString() : "",
                      context);
                } else {
                  Utils.showErrorToast("Please Enter Valid Phone number".tr);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.06,
                width: width * 0.8,
                decoration: const BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Text(
                  "Save Changes".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: labelColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zupee/main.dart';
import 'package:zupee/res/app_colors.dart';

class PrivacyOptionsBottomSheet extends StatefulWidget {
  final String selectedOption;

  const PrivacyOptionsBottomSheet({
    super.key,
    required this.selectedOption,
  });

  @override
  _PrivacyOptionsBottomSheetState createState() {
    return _PrivacyOptionsBottomSheetState();
  }
}

class _PrivacyOptionsBottomSheetState
    extends State<PrivacyOptionsBottomSheet> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 320.0),
            child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close)),
          ),
           Text(
            'Privacy Options: My Game \nHistory'.tr,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.visibility),
            title:  Text('Everyone'.tr),
            subtitle: Text(
              'Anyone on the Zupee platform will be able to see'.tr,
              style: const TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Everyone'.tr,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.visibility,
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title:  Text('Only me'.tr),
            subtitle:  Text(
              'Nobody can see'.tr,
              style: const TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Only me'.tr,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.lock,
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('My Connections'),
            subtitle:  Text(
              'Only your connections (followers and following) will be able to see'.tr,
              style: const TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'My Connections'.tr,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
                Navigator.pop(context, {
                  'option': value,
                  'icon': Icons.people,
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: height * 0.06,
              width: width * 0.8,
              decoration: const BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child:  Text(
                "Done".tr,
                style: const TextStyle(fontWeight: FontWeight.w600, color: tertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

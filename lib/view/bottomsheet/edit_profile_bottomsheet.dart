


import 'package:flutter/material.dart';
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
          const Padding(
            padding: EdgeInsets.only(left: 320.0),
            child: Icon(Icons.close),
          ),
          const Text(
            'Privacy Options: My Game \nHistory',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Everyone'),
            subtitle: const Text(
              'Anyone on the Zupee platform will be able to see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Everyone',
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
            title: const Text('Only me'),
            subtitle: const Text(
              'Nobody can see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'Only me',
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
            subtitle: const Text(
              'Only your connections (followers and following) will be able to see',
              style: TextStyle(fontSize: 10, color: labelColor),
            ),
            trailing: Radio<String>(
              value: 'My Connections',
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
              child: const Text(
                "Done",
                style: TextStyle(fontWeight: FontWeight.w600, color: tertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

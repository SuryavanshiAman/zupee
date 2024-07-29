import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({super.key});

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Your Language'),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Text(locale[index]['name']),
                onTap: () {
                  print(locale[index]['name']);
                  updateLanguage(locale[index]['locale']);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.blue,
            );
          },
          itemCount: locale.length,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zupee/utils/routes_name.dart';

import 'app_colors.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, RoutesName.bottomNevBar,
          //     arguments: {"index": 0});
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.keyboard_arrow_left_rounded,color: black,size: 30,
        ),
      ),
    );
  }
}

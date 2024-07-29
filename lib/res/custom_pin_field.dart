// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

class OtpFieldWidget extends StatefulWidget {
  final int  pinLength;
  final List<TextEditingController>? controllers;
  const OtpFieldWidget({super.key, required this.pinLength, this.controllers});
  @override
  _OtpFieldWidgetState createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<OtpFieldWidget> {
  List<FocusNode> _focusNodes = [];
  List<String> _pinValues = [];

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.pinLength, (index) => FocusNode());
    _pinValues = List.generate(widget.pinLength, (index) => '');
  }



  @override
  void dispose() {
    for (int i = 0; i < widget.pinLength; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _nextField(int index, String value) {
    if (index < widget.pinLength - 1) {
      _focusNodes[index].unfocus();
      _focusNodes[index + 1].requestFocus();
    } else if (index == widget.pinLength - 1) {
      _focusNodes[index].unfocus();
      // Perform verification or any other action here
    }
    setState(() {
      _pinValues[index] = value;
    });
  }

  void _previousField(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
        return Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.all(5),
          child: TextField(
            controller:
                widget.controllers != null ? widget.controllers![index] : null,
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: false,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: const Color(0xffEC6736),
            decoration: InputDecoration(
              counterText: '',
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   borderSide: const BorderSide(color: Color(0xffEC6736)),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   // borderRadius: BorderRadius.circular(8),
              //   // borderSide: const BorderSide(color: Color(0xffEC6736)),
              // ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                _nextField(index, value);
              } else {
                _previousField(index);
              }
            },
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zupee/res/app_colors.dart';

class CustomRichText extends StatelessWidget {
  final List<CustomTextSpan> textSpans;
  final TextAlign? textAlign;
  final void Function()? onTap;

  const CustomRichText(
      {super.key, required this.textSpans, this.textAlign, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];

    for (CustomTextSpan span in textSpans) {
      children.add(
        TextSpan(
            text: span.text,
            style:  TextStyle(
                  fontSize:
                      span.fontSize ?? MediaQuery.of(context).size.width / 65,
                  fontWeight: span.fontWeight ?? FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: span.textColor ?? black,
                  overflow: TextOverflow.ellipsis,
                  height: 1.5),
            ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: textAlign == null ? TextAlign.left : textAlign!,
        text: TextSpan(children: children),
      ),
    );
  }
}

class CustomTextSpan {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  CustomTextSpan({
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });
}

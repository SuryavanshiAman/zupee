import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color
    )
  );
}
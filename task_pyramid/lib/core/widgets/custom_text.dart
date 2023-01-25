import 'package:flutter/material.dart';

Widget customText({
  required String text,
  required Color color,
  required double fontSize,
  FontWeight? fontWeight,
  int? maxLines,
  int? characters,
  TextDecoration? textDecoration,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: textOverflow,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: textDecoration,
    ),
  );
}

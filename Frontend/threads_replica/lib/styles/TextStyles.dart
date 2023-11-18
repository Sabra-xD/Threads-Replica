import 'package:flutter/material.dart';
import 'package:threads_replica/utils/colors.dart';

TextStyle defaultTextStyle(
    {FontWeight? fontWeight, Color? textColor, double? fontSize}) {
  return TextStyle(
    fontWeight: fontWeight ?? FontWeight.bold,
    color: textColor ?? primaryColor,
    fontSize: fontSize ?? 15,
  );
}

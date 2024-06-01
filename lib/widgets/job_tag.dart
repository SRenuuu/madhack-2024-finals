import 'package:flutter/material.dart';

import '../theme/colors.dart';

Widget jobTag(
    {required String tag,
    Color backgroundColor = WorkWiseColors.primaryColor,
    double fontSize = 10}) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      tag,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

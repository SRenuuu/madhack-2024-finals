import 'package:flutter/material.dart';

import '../theme/colors.dart';

Widget loadingIndicator() {
  return const Center(
    child: Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: WorkWiseColors.secondaryColor,
            ),
          ),
          SizedBox(width: 20.0),
          Text(
            'Loading...',
            style: TextStyle(
              color: WorkWiseColors.darkGreyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
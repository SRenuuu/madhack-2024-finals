// Reusable form field widget
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';

Widget formTextField({
  required String label,
  required TextEditingController controller,
  String hintText = '',
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isDense = true,
  bool withFloatingLabel = false,
  bool obscureText = false,
  bool readOnly = false,
  Function()? onTap,
  bool isFilled = true,
  bool showBorder = false,
  bool showShadow = true,
  bool showLabel = true,
  double labelSize = 15.0,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  Color shadowColor = WorkWiseColors.lightGreyColor,
  Color borderColor = WorkWiseColors.greyColor,
  dynamic Function(String)? onSubmitted
}) {
  return withFloatingLabel
      ? Container(
          decoration: showShadow
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onSubmitted: onSubmitted,
              controller: controller,
              maxLines: maxLines,
              obscureText: obscureText,
              keyboardType: keyboardType,
              readOnly: readOnly,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: isDense ? 15.0 : 18.0,
                  fontWeight: FontWeight.w400,
                  color: WorkWiseColors.darkGreyColor,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: showBorder
                      ? BorderSide(
                          width: 1.0,
                          color: borderColor,
                        )
                      : const BorderSide(color: Colors.transparent),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: isDense ? 16.0 : 20.0, horizontal: 12.0),
                border: InputBorder.none,
                labelText: label,
              ),
            ),
          ),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showLabel
                ? Text(
                    label,
                    style: TextStyle(
                        fontSize: labelSize, fontWeight: FontWeight.w500),
                  )
                : Container(),
            SizedBox(height: isDense ? 10.0 : 12.0),
            Container(
              decoration: showShadow
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
              child: TextFormField(
                onFieldSubmitted: onSubmitted,
                controller: controller,
                maxLines: maxLines,
                obscureText: obscureText,
                keyboardType: keyboardType,
                readOnly: readOnly,
                onTap: onTap,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: WorkWiseColors.darkGreyColor,
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    borderSide: showBorder
                        ? BorderSide(
                            width: 1.0,
                            color: borderColor,
                          )
                        : const BorderSide(color: Colors.transparent),
                  ),
                  filled: isFilled,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: isDense ? 14.0 : 20.0, horizontal: 12.0),
                ),
              ),
            ),
          ],
        );
}

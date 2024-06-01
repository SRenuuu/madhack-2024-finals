import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';

Widget formDropdownField({
  required String label,
  required String? selectedValue,
  required List<String> items,
  required Function(String?) onChanged,
  String hintText = '',
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isDense = true,
  bool withFloatingLabel = false,
  bool showBorder = false,
  bool showShadow = true,
  bool showLabel = true,
  double labelSize = 15.0,
  Color shadowColor = WorkWiseColors.lightGreyColor,
  Color borderColor = WorkWiseColors.greyColor,
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
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: WorkWiseColors.greyColor,
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
                    vertical: isDense ? 16.0 : 20.0, horizontal: 16.0),
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
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  onChanged: onChanged,
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: WorkWiseColors.greyColor,
                    ),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: showBorder
                          ? BorderSide(
                              width: 1.0,
                              color: borderColor,
                            )
                          : const BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: isDense ? 14.0 : 18.0, horizontal: 16.0),
                  ),
                ),
              ),
            ),
          ],
        );
}

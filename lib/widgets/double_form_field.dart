import 'package:flutter/material.dart';
//TODO: Convert this to have an actual date input
Widget doubleFormField(
    String label1,
    String value1,
    void Function(String?)? onSaved1,
    String label2,
    String value2,
    void Function(String?)? onSaved2,
    ) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4.0),
            TextFormField(
              initialValue: value1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
              onSaved: onSaved1,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      const SizedBox(width: 8.0), // Add spacing between columns
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label2,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4.0),
            TextFormField(
              initialValue: value2,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
              onSaved: onSaved2,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    ],
  );
}

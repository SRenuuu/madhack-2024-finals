import 'package:flutter/material.dart';

Widget descriptionFormField({
  required String label,
  required String value, // Set a default empty string for value
  int minLines = 5, // Allow at least one line by default
  int maxLines = 5, // Allow unlimited lines by default
  void Function(String?)? onSaved,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 4.0),
      TextFormField(
        initialValue: value,
        keyboardType: TextInputType.multiline, // Enable multiline input
        minLines: minLines, // Set minimum lines
        maxLines: maxLines, // Set maximum lines (if desired)
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        ),
        onSaved: onSaved,
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

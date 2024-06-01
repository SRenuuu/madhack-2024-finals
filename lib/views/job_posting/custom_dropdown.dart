// import 'package:flutter/material.dart';
//
// class CustomDropdown extends StatefulWidget {
//   final List<String> items;
//   final String hintText;
//   final void Function(String) onChanged;
//
//   CustomDropdown({required this.items, required this.onChanged, required this.hintText});
//
//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }
//
// class _CustomDropdownState extends State<CustomDropdown> {
//   String ? _selectedItem;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: _selectedItem,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedItem = newValue;
//         });
//         widget.onChanged(newValue!);
//       },
//       items: widget.items.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

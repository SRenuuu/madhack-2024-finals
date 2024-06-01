import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final int? lines;

  const CustomInput({Key? key, this.onChanged, this.hint, this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        maxLines: lines,
        onChanged: onChanged != null ? (v) => onChanged!(v) : null,
        decoration: InputDecoration(
          labelText: hint ?? '',
        ),
      ),
    );
  }
}

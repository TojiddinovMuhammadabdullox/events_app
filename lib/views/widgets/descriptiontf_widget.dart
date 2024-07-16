// lib/views/widgets/descriptiontf_widget.dart
import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final Function(String?) onSaved;

  const DescriptionTextField({required this.onSaved, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Tadbir haqida ma'lumot",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE1691B), width: 5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE1691B), width: 5),
        ),
      ),
      onSaved: onSaved,
    );
  }
}

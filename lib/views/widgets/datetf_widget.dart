import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Kuni",
        suffixIcon: IconButton(
          onPressed: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2500),
            );
          },
          icon: const Icon(
            Icons.calendar_month,
            color: Colors.grey,
          ),
        ),
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
    );
  }
}
import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  final Function(String?) onSaved;

  const DateTextField({required this.onSaved, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Kuni",
        suffixIcon: IconButton(
          onPressed: () {
            showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2500),
              initialDate: DateTime.now(),
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
      onSaved: onSaved,
    );
  }
}

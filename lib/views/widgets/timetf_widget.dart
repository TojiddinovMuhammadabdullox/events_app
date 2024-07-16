import 'package:flutter/material.dart';

class TimeTextField extends StatelessWidget {
  final Function(String?) onSaved;

  const TimeTextField({required this.onSaved, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Vaqt",
        suffixIcon: IconButton(
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
          },
          icon: const Icon(
            Icons.access_time_outlined,
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

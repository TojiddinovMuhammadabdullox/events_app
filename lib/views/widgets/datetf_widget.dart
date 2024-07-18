// lib/views/widgets/datetf_widget.dart
import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateTextField({
    required this.onDateSelected,
    this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: selectedDate != null
            ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
            : "Kuni",
        suffixIcon: IconButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2500),
              initialDate: selectedDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
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

import 'package:flutter/material.dart';

class TimeTextField extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimeTextField({
    required this.onTimeSelected,
    this.selectedTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: selectedTime != null
            ? "${selectedTime!.hour}:${selectedTime!.minute}"
            : "Vaqt",
        suffixIcon: IconButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (pickedTime != null) {
              onTimeSelected(pickedTime);
            }
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController controller;

  const TimePicker({Key? key, required this.controller}) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      // Format the time to "HH:mm" or customize as needed
      String formattedTime = picked.format(context);
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: AbsorbPointer(
        child: SizedBox(
          height: 80,
          width: 140,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Select Time',
              hintText: 'Tap to select time',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

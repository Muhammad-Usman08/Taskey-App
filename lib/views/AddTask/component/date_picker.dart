import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final TextEditingController controller;

  const DatePicker({Key? key, required this.controller}) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the date to "November 01, 2024"
      controller.text = DateFormat('MMMM dd, yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            
            labelText: 'Select Date',
            hintText: 'Tap to select a date',
            border: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10),
              
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color:Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10),
              
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10),
              
            ),
          ),
        ),
      ),
    );
  }
}

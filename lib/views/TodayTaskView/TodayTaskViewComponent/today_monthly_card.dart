import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/views/MonthlyTask/monthly_task_view.dart';

class TodayMonthlyCard extends StatelessWidget {
  const TodayMonthlyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('MMMM, d').format(today);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '${formattedDate} ✍',
                weight: FontWeight.bold,
                fontSize: 30,
              ),
            ],
          ),
          Container(
            height: 60,
            width: 60,
            child: IconButton(
                onPressed: () {
                  Get.to(MonthlyTaskView());
                },
                icon: Icon(Icons.calendar_month_outlined)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey.shade300,
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class MonthlyCard extends StatelessWidget {
  const MonthlyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = _getMonthName(now.month);
    final day = now.day;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '$month, $day  ✍',
                weight: FontWeight.bold,
                fontSize: 30,
              ),
              CustomText(
                text: '15 Task Today',
                color: Colors.grey.shade500,
              ),
            ],
          ),
          Container(
            height: 60,
            width: 60,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                )),
            decoration: BoxDecoration(
                color: Color(themeColor),
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

String _getMonthName(int month) {
  const monthNames = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return monthNames[month];
}

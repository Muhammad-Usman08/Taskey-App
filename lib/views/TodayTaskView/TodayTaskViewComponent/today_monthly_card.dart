import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class TodayMonthlyCard extends StatelessWidget {
  const TodayMonthlyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'October, 20  ✍',
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
                onPressed: () {}, icon: Icon(Icons.calendar_month_outlined)),
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

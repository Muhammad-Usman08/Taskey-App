import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class InProgressTile extends StatelessWidget {
  const InProgressTile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: inProgress[index]['title'],
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 2,
              ),
              CustomText(
                text: inProgress[index]['subtitle'],
                fontSize: 18,
                weight: FontWeight.bold,
              ),
              SizedBox(
                height: 2,
              ),
              CustomText(
                text: inProgress[index]['time'],
                color: Colors.grey.shade400,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  value: progressValues[index] / totalValues[index],
                  backgroundColor: Color(themeColor).withOpacity(0.2),
                  color: Color(themeColor),
                ),
              ),
              CustomText(
                text: '${progressValues[index]}%',
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<int> progressValues = [50, 30, 70];
List<int> totalValues = [80, 100, 90];

List inProgress = [
  {
    'title': 'Productivity Mobile App',
    'subtitle': 'Create Detail Booking',
    'time': '2 min ago',
  },
  {
    'title': 'Banking Mobile App',
    'subtitle': 'Revision Home Page',
    'time': '5 min ago',
  },
  {
    'title': 'Online Course',
    'subtitle': 'Working On Landing Page',
    'time': '7 min ago',
  },
];

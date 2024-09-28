import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/home/home_view_model.dart';

class InProgressTiles extends StatelessWidget {
  InProgressTiles({
    super.key,
    required this.index,
    required this.taskName,
    required this.taskDescription,
    this.startTime,
    this.endTime,
    required this.progressValues,
    required this.totalValues,
    required this.value,
  });

  final int index;
  final String? taskName;
  final String? taskDescription;
  final String? startTime;
  final String? endTime;
  final int progressValues;
  final int totalValues;
  final double value;

  var controller = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(18),
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
                text: taskName ?? 'No Task Name',
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: taskDescription ?? 'No Description',
                fontSize: 17,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CustomText(
                    text: '${startTime ?? ''} - ',
                    color: Colors.grey.shade400,
                  ),
                  CustomText(
                    text: endTime ?? '',
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: CircularProgressIndicator(
                  strokeWidth: 6.0,
                  value: value,
                  backgroundColor: Color(themeColor).withOpacity(0.2),
                  color: Color(themeColor),
                ),
              ),
              CustomText(
                text: '${progressValues}%',
              )
            ],
          ),
        ],
      ),
    );
  }
}


// List<int> progressValues = [50, 30, 70];
// List<int> totalValues = [80, 100, 90];
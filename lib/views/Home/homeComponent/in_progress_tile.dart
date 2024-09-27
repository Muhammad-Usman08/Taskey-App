import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/views/home/home_view_model.dart';

class InProgressTile extends StatelessWidget {
  InProgressTile({
    super.key,
    required this.index,
    required this.taskName,
    required this.taskDescription,
    this.startTime,
    this.endTime,
  });

  final int index;
  final String? taskName;
  final String? taskDescription;
  final String? startTime;
  final String? endTime;

  var controller = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
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
    );
  }
}

//  Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 50.0,
//                 height: 50.0,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 4.0,
//                   value: progressValues[index] / totalValues[index],
//                   backgroundColor: Color(themeColor).withOpacity(0.2),
//                   color: Color(themeColor),
//                 ),
//               ),
//               CustomText(
//                 text: '${progressValues[index]}%',
//               )
//             ],
//           ),
// List<int> progressValues = [50, 30, 70];
// List<int> totalValues = [80, 100, 90];
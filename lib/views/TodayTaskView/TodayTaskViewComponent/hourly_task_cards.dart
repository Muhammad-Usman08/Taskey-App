import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/views/TodayTaskView/today_task_view_model.dart';

class HourlyTaskCard extends StatelessWidget {
  final Task task;

   HourlyTaskCard({Key? key, required this.task}) : super(key: key);

  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColors[task.hashCode % cardColors.length], // Unique color for each task
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: task.taskName.isNotEmpty ? task.taskName : 'No Task Name',
              color: Colors.white,
              weight: FontWeight.bold,
              fontSize: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  width: 90,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(
                      task.teamMembers.length,
                      (i) {
                        return Positioned(
                          left: i * 20.0,
                          child: ClipOval(
                            child: Image.network(
                              task.teamMembers[i]['imageUrl'] ?? '',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.grey,
                                  child: Center(child: Text('N/A', style: TextStyle(color: Colors.white))),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CustomText(
                  text: '${task.startTime} - ${task.endTime}',
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

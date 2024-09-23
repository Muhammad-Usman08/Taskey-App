import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Color(themeColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 10, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title and subtitle based on the index
            CustomText(
              text: taskTitles[index],
              weight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
            CustomText(
              text: taskSubtitles[index],
              color: Colors.white60,
            ),
            const SizedBox(height: 20),

            // Avatar stack and progress bar section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(3, (i) {
                      return Positioned(
                        left: i * 25.0, // Adjust spacing for overlap
                        child: CircleAvatar(
                          radius: 25, // Adjust size as needed
                          backgroundColor: avatarColors[index][i],
                        ),
                      );
                    }),
                  ),
                ),

                // Progress bar and info section
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Progress',
                              color: Colors.white60,
                            ),
                            CustomText(
                              text:
                                  '${progressValues[index]}/${totalValues[index]}',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Dynamic progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progressValues[index] / totalValues[index],
                          backgroundColor: Colors.white.withOpacity(0.2),
                          color: Colors.white,
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Dynamic data for tasks
List<String> taskTitles = [
  'Application Design',
  'Website Development',
  'Brand Identity'
];
List<String> taskSubtitles = [
  'UI Design Kit',
  'Frontend and Backend',
  'Logo and Style Guide'
];
List<int> progressValues = [50, 30, 70];
List<int> totalValues = [80, 100, 90];
List<List<Color>> avatarColors = [
  [Colors.red, Colors.green, Colors.blue],
  [Colors.orange, Colors.purple, Colors.yellow],
  [Colors.cyan, Colors.pink, Colors.teal]
];

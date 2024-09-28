import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.index,
    this.taskName,
    this.taskDescription,
    required this.value,
    required this.targetProgress,
    required this.userProgress,
    required this.image,
    required this.length,
  });
  final int index;
  final String? taskName;
  final String? taskDescription;
  final double value;
  final int targetProgress; // Target Progress
  final int userProgress;
  final image;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      margin: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: const Color(themeColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 10, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title and subtitle based on the index
            CustomText(
              text: taskName ?? 'No Task Name',
              weight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
            CustomText(
              text: taskDescription ?? 'No Description',
              color: Colors.white60,
            ),
            const SizedBox(height: 20),

            // Avatar stack and progress bar section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 110,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(length, (i) {
                      return Positioned(
                        left: i * 25.0, // Adjust spacing for overlap
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: CircleAvatar(
                            radius: 25, // Adjust size as needed
                            backgroundImage: NetworkImage(image[i]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Progress bar and info section
                Expanded(
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
                                  '$userProgress/ $targetProgress', // '${progressValues[index]}/${totalValues[index]}',
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
                          value: value,
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

// List<int> progressValues = [50, 30, 70, 65, 50, 50];
// List<int> totalValues = [80, 100, 90, 100, 90, 100];
// List<List<Color>> avatarColors = [
//   [Colors.red, Colors.green, Colors.blue],
//   [Colors.orange, Colors.purple, Colors.yellow],
//   [Colors.cyan, Colors.pink, Colors.teal]
// ];

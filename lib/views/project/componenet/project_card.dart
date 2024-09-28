import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class ProjectCard extends StatelessWidget {
  ProjectCard({
    super.key,
    required this.taskTitles,
    required this.taskSubtitles,
    required this.value,
    required this.index,
    required this.progressValues,
    required this.totalValues,
    this.image,
    required this.length,
  });

  final String taskTitles;
  final String taskSubtitles;
  final double value;
  final int index;
  final int progressValues;
  final int totalValues;
  final image;
  final int length;

  final List<Color> predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
  ];
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context) {
    Color progressBarColor = index < predefinedColors.length
        ? predefinedColors[index]
        : getRandomColor();
    Color backgroundColor = progressBarColor.withOpacity(0.2);

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: taskTitles,
                fontSize: 20,
                weight: FontWeight.bold,
              ),
              Container(
                padding: EdgeInsets.all(6),
                child: CustomText(text: '${progressValues}/${totalValues}'),
                decoration: BoxDecoration(
                  border: Border.all(color: progressBarColor),
                  borderRadius: BorderRadius.circular(15),
                ),
              )
            ],
          ),
          CustomText(text: taskSubtitles, color: Colors.grey.shade500),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(length, (i) {
                    return Positioned(
                      left: i * 20.0, // Adjust spacing for overlap
                      child: CircleAvatar(
                        radius: 17, // Adjust size as needed
                        backgroundImage: NetworkImage(image[i]),
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
                    const SizedBox(height: 5),

                    // Dynamic progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: value,
                        backgroundColor: backgroundColor,
                        color: progressBarColor,
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade400)),
    );
  }
}

// List<String> taskTitles = [
//   'Unity Dashboard ☺',
//   'Instagram Shots ✍',
//   'Cubbles 🤓',
//   'Ui8 Platfrom 🤠'
// ];
// List<String> taskSubtitles = [
//   ' Design ',
//   'Marketing',
//   'Design',
//   'Design',
// ];
// List<int> totalValues = [20, 20, 20, 20];
// List<int> progressValues = [10, 8, 15, 5];
// List<List<Color>> avatarColors = [
//   [
//     Colors.red,
//     Colors.green,
//   ],
//   [
//     Colors.orange,
//     Colors.purple,
//   ],
//   [
//     Colors.cyan,
//     Colors.pink,
//   ],
//   [
//     Colors.purple,
//     Colors.brown,
//   ]
// ];

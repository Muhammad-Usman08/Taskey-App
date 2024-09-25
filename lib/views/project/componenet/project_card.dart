import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: taskTitles.length,
        itemBuilder: (context, index) {
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
                      text: taskTitles[index],
                      fontSize: 20,
                      weight: FontWeight.bold,
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      child: CustomText(
                          text:
                              '${progressValues[index]}/${totalValues[index]}'),
                      decoration: BoxDecoration(
                        border: Border.all(color: avatarColors[index][0]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  ],
                ),
                CustomText(
                    text: taskSubtitles[index], color: Colors.grey.shade500),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children:
                            List.generate(avatarColors[index].length, (i) {
                          return Positioned(
                            left: i * 20.0, // Adjust spacing for overlap
                            child: CircleAvatar(
                              radius: 17, // Adjust size as needed
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
                          const SizedBox(height: 5),

                          // Dynamic progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progressValues[index] / totalValues[index],
                              backgroundColor:
                                  avatarColors[index][0].withOpacity(0.2),
                              color: avatarColors[index][0],
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
        });
  }
}

List<String> taskTitles = [
  'Unity Dashboard ☺',
  'Instagram Shots ✍',
  'Cubbles 🤓',
  'Ui8 Platfrom 🤠'
];
List<String> taskSubtitles = [
  ' Design ',
  'Marketing',
  'Design',
  'Design',
];
List<int> totalValues = [20, 20, 20, 20];
List<int> progressValues = [10, 8, 15, 5];
List<List<Color>> avatarColors = [
  [
    Colors.red,
    Colors.green,
  ],
  [
    Colors.orange,
    Colors.purple,
  ],
  [
    Colors.cyan,
    Colors.pink,
  ],
  [
    Colors.purple,
    Colors.brown,
  ]
];

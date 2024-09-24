import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class HourlyTaskCards extends StatelessWidget {
  const HourlyTaskCards({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    // Safeguard for index to avoid RangeError
    if (index < 0 || index >= taskTitles.length) {
      return Container(); // or handle this case appropriately
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor[index % cardColor.length], // Ensure no RangeError
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: taskTitles[index],
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
                      avatarColors[index % avatarColors.length].length,
                      (i) {
                        return Positioned(
                          left: i * 20.0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                avatarColors[index % avatarColors.length][i],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CustomText(
                  text: timeRange[index],
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

// Sample data lists
List<String> timeRange = [
  '10am - 11am',
  '11:40am - 12:40pm',
  '01:20pm - 02:20pm'
];
List<String> taskTitles = [
  'Wireframe elements ☺',
  'Mobile app Design 😍',
  'Design Team call 🤗'
];
List<List<Color>> avatarColors = [
  [Colors.orange, Colors.green],
  [Colors.red, Colors.yellow, Colors.deepPurple],
  [Colors.cyan, Colors.teal, Colors.red, Colors.green]
];

List<Color> cardColor = [
  Colors.blue,
  Colors.green,
  Colors.orange,
];

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;
  final String name;

  const AvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Icon(Icons.camera_alt), // Camera icon on the right
      ],
    );
  }
}

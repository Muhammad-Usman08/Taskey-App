import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.icon,
    required this.icon2,
    required this.title,
  });
  final Widget icon;
  final Widget icon2;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: 60,
              child: icon,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  )),
            ),
            CustomText(text: title, fontSize: 20, weight: FontWeight.bold),
            Container(
              height: 80,
              width: 60,
              child: icon2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.grey.shade300)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? weight;
  final Color? color;
  final int? lines;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize = 2,
      this.weight,
      this.color,
      this.lines,
      this.fontStyle,
      this.textOverflow,
      this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: 15,
          color: color,
          fontWeight: weight,
          fontStyle: fontStyle,
          overflow: textOverflow),
    );
  }
}

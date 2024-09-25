import 'package:flutter/material.dart';

class MyCustomTextfield extends StatelessWidget {
  const MyCustomTextfield(
      {super.key,
      this.forceBorder = false,
      this.borderRadius,
      this.fillColor,
      this.obsecur = false,
      this.prefix,
      this.hintText = '',
      this.controller});
  final bool forceBorder;
  final double? borderRadius;
  final Color? fillColor;
  final bool obsecur;
  final String hintText;
  final prefix;
  final controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefix,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
      ),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: BorderSide(color: Colors.red[900]!),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 11),
      borderSide: fillColor == null || forceBorder
          ? const BorderSide(color: Colors.grey)
          : BorderSide.none,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_text.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isTransparent;
  final bool isEnabled;
  final Color? bgColor;
  final Color textColor;
  final Widget? icon;
  final double fontSize;
  final bool isLoading;
  final double horizontalPadding, vertcalPaddingM;

  CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isTransparent = false,
    this.bgColor,
    this.textColor = Colors.white,
    this.icon,
    this.horizontalPadding = 0,
    this.vertcalPaddingM = 3.2,
    this.fontSize = 1.9,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading || !isEnabled ? null : onPressed,
      child: Container(
        width: horizontalPadding > 0 ? null : double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: !isEnabled
              ? Colors.grey[400]
              : isTransparent
                  ? bgColor
                  : bgColor ??
                      const Color(
                          0xffEC2024), // Use bgColor if provided, otherwise default color
          borderRadius: BorderRadius.circular(30),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 21,
                  height: 21,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 20),
                  ],
                  CustomText(
                    text: title,
                    fontSize: fontSize,
                    color: isTransparent ? null : textColor,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
      ),
    );
  }
}

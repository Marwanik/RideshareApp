import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  const CustomFilledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor),
        ),
        minimumSize: Size(double.infinity, 48),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
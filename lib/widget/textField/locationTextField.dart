import 'package:flutter/material.dart';

class CustomLocationTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final TextEditingController controller;

  const CustomLocationTextField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.leadingIcon,
    this.trailingIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
        suffixIcon: trailingIcon != null ? Icon(trailingIcon) : null,
      ),
    );
  }
}

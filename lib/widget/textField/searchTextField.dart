
import 'package:flutter/material.dart';
class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final ValueChanged<String>? onChanged;

  CustomSearchField({
    required this.controller,
    required this.hintText,
    required this.leadingIcon,
    required this.trailingIcon,
    this.onChanged, // Optional parameter for onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(leadingIcon),
        suffixIcon: Icon(trailingIcon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final String hintText;

  const CustomPasswordField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(Icons.visibility_off),
      ),
    );
  }
}

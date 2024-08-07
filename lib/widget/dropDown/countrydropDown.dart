import 'package:flutter/material.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';


class CustomCountryCodePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController Controller;
  const CustomCountryCodePicker({
    Key? key,
    required this.hintText, required this.Controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(width: 8),
              Text('🇧🇩'),
              Icon(Icons.arrow_drop_down),
              SizedBox(width: 8),
            ],
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: CustomTextField(
            hintText: hintText,
            keyboardType: TextInputType.phone, controller: Controller,
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';

class LocationSelectionTile extends StatelessWidget {
  final String hintText;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final Color borderColor;

  const LocationSelectionTile({
    Key? key,
    required this.hintText,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: Colors.grey),
        title: Text(hintText, style: TextStyle(color: Colors.grey)),
        trailing: Icon(trailingIcon, color: Colors.red),
      ),
    );
  }
}

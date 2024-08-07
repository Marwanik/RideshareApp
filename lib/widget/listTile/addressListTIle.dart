
import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final String title;
  final String address;
  final Color iconColor;
  final Widget? trailing;

  const AddressTile({
    Key? key,
    required this.title,
    required this.address,
    required this.iconColor,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.location_on, color: iconColor),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(address),
      trailing: trailing,
    );
  }
}

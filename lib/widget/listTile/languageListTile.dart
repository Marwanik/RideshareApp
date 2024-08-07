import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String name;
  final String subtext;
  final String flagPath;
  final bool isSelected;

  const LanguageTile({
    Key? key,
    required this.name,
    required this.subtext,
    required this.flagPath,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
        color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Image.asset(flagPath, width: 40),
        title: Text(name),
        subtitle: Text(subtext),
        trailing: Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isSelected ? Colors.green : Colors.grey,
        ),
        onTap: () {
          // Handle language selection
        },
      ),
    );
  }
}
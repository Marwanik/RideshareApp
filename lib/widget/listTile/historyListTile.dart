
import 'package:flutter/material.dart';
import 'package:rideshare/widget/tabBar/historyTabBar.dart';

class HistoryListTile extends StatelessWidget {
  final Map<String, String> item;
  final ItemType itemType;

  HistoryListTile({required this.item, required this.itemType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(item['name']!),
        subtitle: Text(item['car']!),
        trailing: Text(
          itemType == ItemType.Upcoming ? item['time']! : item['status']!,
          style: TextStyle(
            color: itemType == ItemType.Completed ? Colors.green : itemType == ItemType.Cancelled ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}
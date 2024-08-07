import 'package:flutter/material.dart';
import 'package:rideshare/widget/listTile/historyListTile.dart';
import 'package:rideshare/widget/tabBar/historyTabBar.dart';

class HistoryListView extends StatelessWidget {
  final List<Map<String, String>> items;
  final ItemType itemType;

  HistoryListView({required this.items, required this.itemType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return HistoryListTile(item: item, itemType: itemType);
      },
    );
  }
}

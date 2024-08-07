import 'package:flutter/material.dart';
import 'package:rideshare/widget/listView/HistoryListView.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green),
              ),

              child: TabBar(
                indicatorPadding: EdgeInsets.only(left:-32,right: -34),
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelPadding: EdgeInsets.symmetric(vertical: 8.0),
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
          ),
        ),
        body: HistoryTabBarView(),
      ),
    );
  }
}

class HistoryTabBarView extends StatelessWidget {
  final List<Map<String, String>> upcoming = [
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Henry", "car": "Mustang Shelby GT", "time": "Today at 10:20 am"},
    {"name": "Willam", "car": "Mustang Shelby GT", "time": "Tomorrow at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Henry", "car": "Mustang Shelby GT", "time": "Today at 10:20 am"},
    {"name": "Willam", "car": "Mustang Shelby GT", "time": "Tomorrow at 09:20 am"},
    {"name": "Nate", "car": "Mustang Shelby GT", "time": "Today at 09:20 am"},
    {"name": "Henry", "car": "Mustang Shelby GT", "time": "Today at 10:20 am"},
    {"name": "Willam", "car": "Mustang Shelby GT", "time": "Tomorrow at 09:20 am"},
  ];

  final List<Map<String, String>> completed = [
    {"name": "Nate", "car": "Mustang Shelby GT", "status": "Done"},
    {"name": "Henry", "car": "Mustang Shelby GT", "status": "Done"},
    {"name": "Willam", "car": "Mustang Shelby GT", "status": "Done"},
  ];

  final List<Map<String, String>> cancelled = [
    {"name": "Nate", "car": "Mustang Shelby GT", "status": "Cancel"},
    {"name": "Henry", "car": "Mustang Shelby GT", "status": "Cancel"},
    {"name": "Willam", "car": "Mustang Shelby GT", "status": "Cancel"},
  ];

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        HistoryListView(items: upcoming, itemType: ItemType.Upcoming),
        HistoryListView(items: completed, itemType: ItemType.Completed),
        HistoryListView(items: cancelled, itemType: ItemType.Cancelled),
      ],
    );
  }
}

enum ItemType { Upcoming, Completed, Cancelled }


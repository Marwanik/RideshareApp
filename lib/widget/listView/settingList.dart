import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final List<Map<String, dynamic>> settingsOptions = [
    {"title": "Change Password", "icon": Icons.lock},
    {"title": "Change Language", "icon": Icons.language},
    {"title": "Privacy Policy", "icon": Icons.privacy_tip},
    {"title": "Contact Us", "icon": Icons.contact_mail},
    {"title": "Delete Account", "icon": Icons.delete},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: settingsOptions.length,
      itemBuilder: (context, index) {
        final item = settingsOptions[index];
        return _buildSettingsTile(item['title'], item['icon']);
      },
    );
  }

  Widget _buildSettingsTile(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          // Handle tap event
        },
      ),
    );
  }
}
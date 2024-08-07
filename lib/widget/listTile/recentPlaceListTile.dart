
import 'package:flutter/material.dart';

class RecentPlaceItem extends StatelessWidget {
  final String place;
  final String address;
  final String distance;

  const RecentPlaceItem({
    Key? key,
    required this.place,
    required this.address,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.location_on, color: Colors.green),
      title: Text(
        place,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      subtitle: Text(address),
      trailing: Text(distance),
    );
  }
}

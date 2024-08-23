import 'package:flutter/material.dart';

class BicycleItemCategory extends StatelessWidget {
  final String model;
  final double price;
  final int size;
  final String type;
  final String photoPath;
  final String note;
  final List<String> maintenanceDetails;
  final VoidCallback onTap;

  const BicycleItemCategory({
    Key? key,
    required this.model,
    required this.price,
    required this.size,
    required this.type,
    required this.photoPath,
    required this.note,
    required this.maintenanceDetails,
    required this.onTap,
  }) : super(key: key);

  void _showMaintenanceDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Maintenance Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: maintenanceDetails.isEmpty
                ? [Text('No maintenance details available')]
                : maintenanceDetails.map((detail) => Text(detail)).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Price: \$$price | Size: $size \nType: $type',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Note: $note',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Image.network(
                'https://$photoPath',
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported);
                },
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green, backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(150, 36),
                ),
                onPressed: () => _showMaintenanceDetails(context),
                child: Text('View Maintenance'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green, backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(150, 36),
                ),
                onPressed: onTap,
                child: Text('Select Bike'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

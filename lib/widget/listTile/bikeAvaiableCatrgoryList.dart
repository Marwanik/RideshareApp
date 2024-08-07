import 'package:flutter/material.dart';

class CarItemCategory extends StatelessWidget {
  final String carName;
  final String carType;
  final String seats;
  final String fuelType;
  final String distance;
  final String imagePath;
  final VoidCallback onTap;

  const CarItemCategory({
    Key? key,
    required this.carName,
    required this.carType,
    required this.seats,
    required this.fuelType,
    required this.distance,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

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
              Image.asset(imagePath, height: 50),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carName,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$carType | $seats seats | $fuelType',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 16),
                        SizedBox(width: 4),
                        Text(
                          distance,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.green, backgroundColor: Colors.white,
              side: BorderSide(color: Colors.green),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: Size(double.infinity, 36),
            ),
            onPressed: onTap,
            child: Text('View car list'),
          ),
        ],
      ),
    );
  }
}
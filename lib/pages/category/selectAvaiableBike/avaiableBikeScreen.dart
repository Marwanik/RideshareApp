import 'package:flutter/material.dart';
import 'package:rideshare/pages/category/avaiableBike/avaiableBikeScreen.dart';
import 'package:rideshare/widget/listTile/bikeAvaiableCatrgoryList.dart';

class CarSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> availableCars = [
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',
    },
    // Add more cars here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available cars for ride'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: availableCars.length,
        itemBuilder: (context, index) {
          final car = availableCars[index];
          return CarItemCategory(
            carName: car['carName']!,
            carType: car['carType']!,
            seats: car['seats']!,
            fuelType: car['fuelType']!,
            distance: car['distance']!,
            imagePath: car['imagePath']!,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>AvailableCarsScreen(),));


                  // Handle the car selection or navigation here
              print('Selected: ${car['carName']}');
            },
          );
        },
      ),
    );
  }
}

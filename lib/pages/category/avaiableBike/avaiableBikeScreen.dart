import 'package:flutter/material.dart';
import 'package:rideshare/pages/bikeDetails/bikeDetailsScreen.dart';
import 'package:rideshare/widget/listTile/bikeAvailableSelection.dart';

class AvailableCarsScreen extends StatelessWidget {
  final List<Map<String, String>> availableCars = [
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'BMW Cabrio',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'Mustang Shelby GT',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    {
      'carName': 'BMW i8',
      'carType': 'Automatic',
      'seats': '3',
      'fuelType': 'Octane',
      'distance': '800m (5mins away)',
      'imagePath': 'assets/images/category/Bike.jpg',  // Update with the correct path
    },
    // Add more cars as needed
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
          return CarItemSelection(
            carName: car['carName']!,
            carType: car['carType']!,
            seats: car['seats']!,
            fuelType: car['fuelType']!,
            distance: car['distance']!,
            imagePath: car['imagePath']!,
            onBookLater: () {
              // Handle book later action
              print('Book later: ${car['carName']}');
            },
            onRideNow: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>CarDetailsScreen(),)
              );


                  print('Ride Now: ${car['carName']}');
            },
          );
        },
      ),
    );
  }
}

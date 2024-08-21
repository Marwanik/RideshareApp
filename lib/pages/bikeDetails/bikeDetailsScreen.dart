import 'package:flutter/material.dart';
import 'package:rideshare/pages/rentRequest/requestRentBike/requestRenrScreen.dart';
import 'package:rideshare/widget/container/bikeFeatureContainer.dart';
import 'package:rideshare/widget/container/bikeSpecificationContainer.dart';

class CarDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mustang Shelby GT'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Mustang Shelby GT',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text('4.9 (531 reviews)'),
                    ],
                  ),
                SizedBox(height: 10,),
                  Image.asset(
                    'assets/images/category/Bike.jpg', // Replace with your image path
                    height: 200,
                  ),
                  SizedBox(height: 8),


                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Specifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpecificationItem(label: 'Max power', value: '500hp'),
                SpecificationItem(label: 'Fuel', value: 'Gasoline'),
                SpecificationItem(label: 'Max speed', value: '250km/h'),
                SpecificationItem(label: '0-60mph', value: '3.5s'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Car features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            FeatureItem(label: 'Model', value: 'GT5000'),
            FeatureItem(label: 'Capacity', value: '760hp'),
            FeatureItem(label: 'Color', value: 'Red'),
            FeatureItem(label: 'Fuel type', value: 'Octane'),
            FeatureItem(label: 'Gear type', value: 'Automatic'),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    onPressed: () {
                      // Book later action
                    },
                    child: Text('Book later'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>RequestRentScreen(),)



                      );
                    },
                    child: Text('Ride Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
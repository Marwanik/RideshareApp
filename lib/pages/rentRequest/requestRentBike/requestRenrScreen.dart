import 'package:flutter/material.dart';
import 'package:rideshare/pages/rentRequest/confirmRentBike/confirmRentBikeScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/container/bikeDetailsContainer.dart';
import 'package:rideshare/widget/container/paymentMethodContainer.dart';
import 'package:rideshare/widget/listTile/addressListTIle.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class RequestRentScreen extends StatelessWidget {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request for rent'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressTile(
              title: 'Current location',
              address: '2172 Westheimer Rd, Santa Ana, Illinois 85486',
              iconColor: Colors.red,
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            SizedBox(height: 8),
            AddressTile(
              title: 'Office',
              address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
              iconColor: Colors.green,
              trailing: Text('1.1km'),
            ),
            SizedBox(height: 16),
            CarInfoCard(
              carName: 'Mustang Shelby GT',
              rating: 4.9,
              reviews: 531,
              imagePath: 'assets/images/category/Bike.jpg',
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Date',
              controller: dateController,
              readOnly: true,
              onTap: () {
                // Handle date picker
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Time',
              controller: timeController,
              readOnly: true,
              onTap: () {
                // Handle time picker
              },
            ),
            SizedBox(height: 16),
            Text(
              'Select payment method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            StatefulBuilder(
              builder: (context, setState) =>  Column(
                children: [
                  PaymentMethodItem(
                    label: '**** **** **** 8970',
                    type: 'VISA',
                    expiry: 'Expires 12/26',
                    isSelected: selectedIndex == 0,
                    onTap: () => setState(() => selectedIndex = 0),
                  ),

                  PaymentMethodItem(
                    label: '**** **** **** 1234',
                    type: 'MasterCard',
                    expiry: 'Expires 12/25',
                    isSelected: selectedIndex == 1,
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  PaymentMethodItem(
                    label: 'mailaddress@mail.com',
                    type: 'PayPal',
                    expiry: 'Expires 12/26',
                    isSelected: selectedIndex == 2,
                    onTap: () => setState(() => selectedIndex = 2),
                  ),
                  PaymentMethodItem(
                    label: 'Cash',
                    type: 'Cash',
                    expiry: '',
                    isSelected: selectedIndex == 3,
                    onTap: () => setState(() => selectedIndex = 3),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomFilledButton(
              text: 'Confirm Ride',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmrentbikescreen(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

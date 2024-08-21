import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/container/paymentMethodContainer.dart';
import 'package:rideshare/widget/dropDown/dropDown.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class BankAmountScreen extends StatelessWidget {
  final TextEditingController accountNumberController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amount'),
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
            CustomDropdown(
              hintText: 'Select Payment Method',
              items: ['VISA', 'MasterCard', 'PayPal', 'Cash'],
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Account Number',
              controller: accountNumberController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            CustomFilledButton(
              text: 'Save Payment Method',
              onPressed: () {
                _showSuccessDialog(context); // Show success dialog
              },
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView(children: [
                StatefulBuilder(
                  builder: (context, setState) => Column(
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
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                SizedBox(height: 16),
                Text(
                  'Add Success',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  'Your money has been added successfully',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  '\$220',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                CustomFilledButton(
                  text: 'Back Home',
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to home
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

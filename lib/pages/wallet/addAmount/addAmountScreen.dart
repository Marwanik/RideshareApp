import 'package:flutter/material.dart';
import 'package:rideshare/pages/wallet/bank/bankScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/container/paymentMethodContainer.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class AddAmountScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
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
            CustomTextField(
              hintText: 'Enter Amount',
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Handle add payment method action
                },
                child: Text(
                  'Add payment Method',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Method',
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
              text: 'Confirm',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BankAmountScreen(),
                    ));
              },
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

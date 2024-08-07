import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/listTile/addressListTIle.dart';

class AddressConfirmationBottomSheet extends StatelessWidget {
  final VoidCallback onEdit;

  const AddressConfirmationBottomSheet({
    Key? key,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 40,
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Select address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          AddressTile(
            title: 'Current location',
            address: '2972 Westheimer Rd. Santa Ana, Illinois 85486',
            iconColor: Colors.red,
            trailing: null,
          ),
          AddressTile(
            title: 'Office',
            address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
            iconColor: Colors.green,
            trailing: Text('1.1km', style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 16),
          CustomFilledButton(
            text: 'Confirm Location',
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

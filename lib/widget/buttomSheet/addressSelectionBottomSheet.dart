import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/mainButton.dart'; // Ensure these paths are correct
import 'package:rideshare/widget/listTile/recentPlaceListTile.dart'; // Ensure these paths are correct
import 'package:rideshare/widget/textField/mainTextFiled.dart'; // Ensure these paths are correct

class AddressSelectionBottomSheet extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final VoidCallback onConfirm;

  const AddressSelectionBottomSheet({
    Key? key,
    required this.fromController,
    required this.toController,
    required this.onConfirm,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          CustomTextField(
            controller: fromController,
            hintText: 'From',
          ),
          SizedBox(height: 8),
          CustomTextField(
            controller: toController,
            hintText: 'To',
          ),
          SizedBox(height: 16),
          Text(
            'Recent places',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          RecentPlaceItem(
            place: 'Office',
            address: '2972 Westheimer Rd. Santa Ana, Illinois 85486',
            distance: '2.7km',
          ),
          RecentPlaceItem(
            place: 'Coffee shop',
            address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
            distance: '1.1km',
          ),
          RecentPlaceItem(
            place: 'Shopping center',
            address: '4140 Parker Rd. Allentown, New Mexico 31134',
            distance: '4.9km',
          ),
          RecentPlaceItem(
            place: 'Shopping mall',
            address: '4140 Parker Rd. Allentown, New Mexico 31134',
            distance: '4.0km',
          ),
          SizedBox(height: 16),
          CustomFilledButton(
            text: 'Confirm Location',
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}

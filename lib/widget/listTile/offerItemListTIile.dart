import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/customSmallButton.dart';

class OfferItemListTile extends StatelessWidget {
  final String discount;
  final String event;

  OfferItemListTile({required this.discount, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.green,
          width: 1,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        title: Text(
          discount,
          style: TextStyle(
            color: Colors.orange,
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
            height: 1.5,
          ),
        ),
        subtitle: Text(
          event,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Segoe UI',
            fontSize: 14,
            letterSpacing: 0.3,
            height: 1.4,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: CustomButton(text: 'Collect', onPressed: (){})

          ),
        ),

    );
  }
}
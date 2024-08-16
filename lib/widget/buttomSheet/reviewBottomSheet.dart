import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/button/tipButton.dart';

class ReviewBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Excellent',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'You rated Sergio Ramasis 4 star',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: Colors.amber,
                size: 32,
              );
            }),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Write your text',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 4,
          ),
          SizedBox(height: 16),
          Text(
            'Give some tips to Sergio Ramasis',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TipButton(amount: '\$1'),
              TipButton(amount: '\$2'),
              TipButton(amount: '\$5'),
              TipButton(amount: '\$10'),
              TipButton(amount: '\$20'),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter other amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          CustomFilledButton(
            text: 'Submit',
            onPressed: () {
              // Handle submission
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
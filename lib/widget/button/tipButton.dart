import 'package:flutter/material.dart';

class TipButton extends StatelessWidget {
  final String amount;

  const TipButton({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: Colors.green),
      ),
      onPressed: () {},
      child: Text(
        amount,
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
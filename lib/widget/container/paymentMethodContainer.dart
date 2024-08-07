import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final String label;
  final String type;
  final String expiry;

  const PaymentMethodItem({
    Key? key,
    required this.label,
    required this.type,
    required this.expiry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, color: Colors.green),
          SizedBox(width: 8),
          Text(label),
          Spacer(),
          Text(expiry, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
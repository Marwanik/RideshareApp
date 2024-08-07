import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String amount;
  final String label;

  const BalanceCard({
    Key? key,
    required this.amount,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          Text(
            amount,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}

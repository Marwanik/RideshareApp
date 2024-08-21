import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String name;
  final String time;
  final String amount;
  final String type;

  const TransactionItem({
    Key? key,
    required this.name,
    required this.time,
    required this.amount,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xff08B783)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: type == 'credit' ? Colors.green[100] : Colors.red[100],
          child: Icon(
            type == 'credit' ? Icons.arrow_downward : Icons.arrow_upward,
            color: type == 'credit' ? Colors.green : Colors.red,
          ),
        ),
        title: Text(name),
        subtitle: Text(time),
        trailing: Text(
          amount,
          style: TextStyle(
            color: type == 'credit' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
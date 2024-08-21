import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final String label;
  final String type;
  final String expiry;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodItem({
    Key? key,
    required this.label,
    required this.type,
    required this.expiry,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.credit_card,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Spacer(),
            Text(
              expiry,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

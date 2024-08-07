
import 'package:flutter/material.dart';

class CircularProgressButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final double progress;

  const CircularProgressButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.progress,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.green[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            strokeWidth: 4.0,
          ),
        ),
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white, size: 30)
                  : Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

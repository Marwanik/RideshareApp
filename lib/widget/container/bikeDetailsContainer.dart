import 'package:flutter/material.dart';

class CarInfoCard extends StatelessWidget {
  final String imagePath;
  final String carName;
  final double rating;
  final int reviews;

  const CarInfoCard({
    Key? key,
    required this.imagePath,
    required this.carName,
    required this.rating,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text('$rating ($reviews reviews)'),
                  ],
                ),
              ],
            ),
            Image.asset(imagePath, height: 50),

          ],
        ),
      ),
    );
  }
}

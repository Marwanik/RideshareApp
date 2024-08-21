import 'package:flutter/material.dart';
import 'package:rideshare/pages/favourite/favouriteScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 16),
              Text(
                'Thank you',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your booking has been placed and sent to Md. Sharif Ahmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              CustomFilledButton(
                text: 'Confirm Ride',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>FavouriteScreen(),)
                  );
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}

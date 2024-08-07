import 'package:flutter/material.dart';
import 'package:rideshare/pages/signUp/signupScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/button/outlineButton.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            Image.asset(
              'assets/images/signUp/welcome.png', // Replace with your image path
              height: 200,
            ),
            Spacer(flex: 2),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Have a better sharing experience',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(flex: 3),
            CustomFilledButton(
              text: 'Create an account',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => signupScreen()),
                );
              },
            ),
            SizedBox(height: 16),
            CustomOutlinedButton(
              text: 'Log In',
              onPressed: () {
                // Handle log in action
              },
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
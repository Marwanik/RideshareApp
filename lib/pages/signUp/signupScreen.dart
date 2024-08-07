
import 'package:flutter/material.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/button/outlineButton.dart';
import 'package:rideshare/widget/checkBox/checkBox.dart';
import 'package:rideshare/widget/dropDown/countrydropDown.dart';
import 'package:rideshare/widget/dropDown/dropDown.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class signupScreen extends StatefulWidget {
  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up with your email or phone number'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextField(
              hintText: 'Name',
              controller: nameController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(height: 16),
            CustomCountryCodePicker(
              hintText: 'Your mobile number',
              Controller: phoneController,
            ),
            SizedBox(height: 16),
            CustomDropdown(
              hintText: 'Gender',
              items: ['Male', 'Female', 'Other'],
            ),
            SizedBox(height: 16),
            CustomCheckbox(
              value: isChecked,
              text: 'By signing up, you agree to the',
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            SizedBox(height: 16),
            CustomFilledButton(
              text: 'Sign Up',
              onPressed: () {
                // Handle sign up action
              },
            ),
            SizedBox(height: 16),
            Divider(),
            CustomOutlinedButton(
              text: 'Sign up with Gmail',
              icon: Icons.email,
              onPressed: () {
                // Handle sign up with Gmail action
              },
            ),
            SizedBox(height: 16),
            CustomOutlinedButton(
              text: 'Sign up with Facebook',
              icon: Icons.facebook,
              onPressed: () {
                // Handle sign up with Facebook action
              },
            ),
            SizedBox(height: 16),
            CustomOutlinedButton(
              text: 'Sign up with Apple',
              icon: Icons.apple,
              onPressed: () {
                // Handle sign up with Apple action
              },
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Handle sign in action
              },
              child: Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
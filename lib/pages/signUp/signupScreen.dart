import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/auth_bloc.dart';
import 'package:rideshare/model/userModel.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up with your email or phone number'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Loading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is Success) {
            // Handle success scenario
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Signup Successful')),
            );
          } else if (state is Failed) {
            // Handle failure scenario
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
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
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPasswordController,
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
                  _onSignupButtonPressed(context);
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
      ),
    );
  }

  void _onSignupButtonPressed(BuildContext context) {
    final user = UserModel(
      firstName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    // Dispatch signup event
    context.read<AuthBloc>().add(SignUp(user));
  }
}

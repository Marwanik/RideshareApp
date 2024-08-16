import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/authBlocRegister.dart';
import 'package:rideshare/bloc/authEventRegister.dart';
import 'package:rideshare/bloc/authStateRegister.dart';
import 'package:rideshare/model/registerModel.dart';
import 'package:rideshare/pages/home/homeScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/button/outlineButton.dart';
import 'package:rideshare/widget/checkBox/checkBox.dart';
import 'package:rideshare/widget/dropDown/countrydropDown.dart';
import 'package:rideshare/widget/dropDown/dropDown.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocListener<AuthBlocRegister, AuthStateRegister>(
        listener: (context, state) {
          if (state is LoadingRegister) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is SuccessRegister) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),  // Navigate to HomePage
            );
          } else if (state is FailedRegister) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [

              SizedBox(height: 50,),
              CustomTextField(
                hintText: 'First Name',
                controller: firstnameController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Last Name',
                controller: lastnameController,
              ),
              SizedBox(height: 16),
              CustomCountryCodePicker(
                hintText: 'Your mobile number',
                Controller: phoneController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'UserName',
                keyboardType: TextInputType.name,
                controller: userNameController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Birth Date',
                keyboardType: TextInputType.text,
                controller: birthDateController,
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
    final user = RegisterModel(
      firstName: firstnameController.text.trim(),
      lastName: lastnameController.text.trim(),
      phone: phoneController.text.trim(),
      username: userNameController.text.trim(),
      birthDate: birthDateController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    context.read<AuthBlocRegister>().add(SignUp(user));
  }
}

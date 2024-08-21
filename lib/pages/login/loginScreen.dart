import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Login/AuthEventLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/model/loginModel.dart';
import 'package:rideshare/pages/home/homeScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/textField/mainTextFiled.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<AuthBlocLogin, AuthStateLogin>(
        listener: (context, state) {
          if (state is LoadingLogin) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is SuccessLogin) {
            Navigator.pop(context); // Close the loading dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),  // Navigate to HomePage
            );
          } else if (state is FailedLogin) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  CustomTextField(
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 32),
                  CustomFilledButton(
                    text: 'Login',
                    onPressed: () {
                      _onLoginButtonPressed(context);
                    },
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Handle sign up action
                    },
                    child: Text('Don\'t have an account? Sign up'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    final user = LoginModel(
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    context.read<AuthBlocLogin>().add(Login(user));  // Correctly pass LoginModel
  }
}

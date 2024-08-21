import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Register/authBlocRegister.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/pages/login/loginScreen.dart';
import 'package:rideshare/pages/signUp/signupScreen.dart';
import 'package:rideshare/repos/AuthRepoLogin.dart';
import 'package:rideshare/repos/AuthRepoRegister.dart';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AuthBlocRegister(
                        // Inject the AuthRepo from the service locator
                        sl.get<AuthRepoRegister>(),
                      ),
                      child: SignupScreen(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            CustomOutlinedButton(
              text: 'Log In',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                        create: (context) => AuthBlocLogin(
                    // Inject the AuthRepo from the service locator
                    sl.get<AuthRepoLogin>(),
                ),
                child: LoginScreen(),
                )));

              },
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
